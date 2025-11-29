import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/timer_model.dart';
import '../services/notification_service.dart';
import '../services/statistics_service.dart';
import '../widgets/timer_display.dart';
import '../widgets/timer_controls.dart';
import '../l10n/app_localizations.dart';

class TimerScreen extends StatefulWidget {
  final TimerModel timer;

  const TimerScreen({super.key, required this.timer});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  late Duration _remainingTime;
  late Duration _totalTime;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isCompleted = false;
  late AnimationController _animationController;
  late AnimationController _pulseController;

  // Переменные для отслеживания сессии
  DateTime? _sessionStartTime;
  String? _sessionId;

  @override
  void initState() {
    print("aasd");
    super.initState();
    _totalTime = widget.timer.duration;
    _remainingTime = widget.timer.duration;

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    // Сохранить сессию при выходе из экрана, если таймер был запущен
    if (_isRunning || _isPaused) {
      _saveSession(false);
    }

    _timer.cancel();
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (widget.timer.type == TimerType.stopwatch) {
      _startStopwatch();
    } else {
      _startCountdown();
    }
  }

  void _startCountdown() {
    if (_remainingTime.inSeconds <= 0) return;

    setState(() {
      _isRunning = true;
      _isPaused = false;
      _sessionStartTime = DateTime.now();
      _sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        } else {
          _completeTimer();
          timer.cancel();
        }
      });
    });
  }

  void _startStopwatch() {
    setState(() {
      _isRunning = true;
      _isPaused = false;
      _sessionStartTime = DateTime.now();
      _sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = _remainingTime + const Duration(seconds: 1);
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    _timer.cancel();

    // Сохранить сессию как незавершенную при паузе
    _saveSession(false);
  }

  void _resumeTimer() {
    if (widget.timer.type == TimerType.stopwatch) {
      _startStopwatch();
    } else {
      _startCountdown();
    }
  }

  void _resetTimer() {
    // Сохранить сессию перед сбросом, если таймер был запущен
    if (_isRunning || _isPaused) {
      _saveSession(false);
    }

    setState(() {
      _isRunning = false;
      _isPaused = false;
      _isCompleted = false;
      _remainingTime = widget.timer.duration;
      _sessionStartTime = null;
      _sessionId = null;
    });
    _timer.cancel();
    _pulseController.reset();
  }

  void _completeTimer() {
    setState(() {
      _isRunning = false;
      _isCompleted = true;
    });

    _pulseController.repeat();

    // Сохранить сессию
    _saveSession(true);

    final loc = AppLocalizations.of(context)!;
    // Показать уведомление
    print("NotificationService");

    NotificationService().showTimerNotification(
      title: loc.timerFinishedTitle,
      body: loc.timerFinishedBody(widget.timer.name),
      id: int.parse(widget.timer.id),
      channelName: loc.notificationChannelName,
      channelDescription: loc.notificationChannelDescription,
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  double _getProgress() {
    if (widget.timer.type == TimerType.stopwatch) {
      return 0.0; // Для секундомера прогресс не нужен
    }

    if (_totalTime.inSeconds == 0) return 0.0;

    final elapsed = _totalTime.inSeconds - _remainingTime.inSeconds;
    return elapsed / _totalTime.inSeconds;
  }

  void _saveSession(bool isCompleted) {
    if (_sessionStartTime == null || _sessionId == null) return;

    final statsService = Provider.of<StatisticsService>(context, listen: false);
    final endTime = DateTime.now();
    Duration sessionDuration;

    if (widget.timer.type == TimerType.stopwatch) {
      sessionDuration = _remainingTime;
    } else {
      sessionDuration = widget.timer.duration - _remainingTime;
    }

    final session = TimerSession(
      id: _sessionId!,
      timerId: widget.timer.id,
      timerName: widget.timer.name,
      timerType: widget.timer.type,
      duration: sessionDuration,
      startTime: _sessionStartTime!,
      endTime: endTime,
      isCompleted: isCompleted,
    );

    statsService.addSession(session);

    // Показать уведомление о сохранении сессии (только если не завершена)
    if (!isCompleted) {
      final loc = AppLocalizations.of(context)!;
      NotificationService().showTimerNotification(
        title: loc.sessionSavedTitle,
        body: loc.sessionSavedBody,
        id:
            int.parse(widget.timer.id) +
            1000, // Используем другой ID для избежания конфликтов
        channelName: loc.notificationChannelName,
        channelDescription: loc.notificationChannelDescription,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBackground());
  }

  Widget _buildBackground() {
    switch (widget.timer.style) {
      case TimerStyle.classic:
        return _buildClassicBackground();
      case TimerStyle.modern:
        return _buildModernBackground();
      case TimerStyle.gradient:
        return _buildGradientBackground();
      case TimerStyle.neon:
        return _buildNeonBackground();
      case TimerStyle.minimal:
        return _buildMinimalBackground();
      case TimerStyle.retro:
        return _buildRetroBackground();
    }
  }

  Widget _buildClassicBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, widget.timer.primaryColor.withOpacity(0.1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.timer.primaryColor, widget.timer.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.timer.primaryColor.withOpacity(0.8),
            widget.timer.secondaryColor.withOpacity(0.6),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: widget.timer.primaryColor.withOpacity(0.3),
            blurRadius: 50,
            spreadRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinimalBackground() {
    return Container(
      color: Colors.grey[50],
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetroBackground() {
    return Container(
      decoration: BoxDecoration(
        color: widget.timer.primaryColor.withOpacity(0.1),
        border: Border.all(
          color: widget.timer.primaryColor.withOpacity(0.3),
          width: 5,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimerDisplay(),
                    const SizedBox(height: 40),
                    _buildControls(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Сохранить сессию при выходе, если таймер был запущен
              if (_isRunning || _isPaused) {
                _saveSession(false);
              }
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: _getAppBarIconColor()),
          ),
          Expanded(
            child: Text(
              widget.timer.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _getAppBarTextColor(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48), // Для баланса
        ],
      ),
    );
  }

  Color _getAppBarIconColor() {
    final theme = Theme.of(context);
    switch (widget.timer.style) {
      case TimerStyle.classic:
      case TimerStyle.minimal:
        return theme.textTheme.bodyLarge?.color ?? Colors.black87;
      case TimerStyle.modern:
      case TimerStyle.gradient:
      case TimerStyle.neon:
      case TimerStyle.retro:
        return Colors.white;
    }
  }

  Color _getAppBarTextColor() {
    final theme = Theme.of(context);
    switch (widget.timer.style) {
      case TimerStyle.classic:
      case TimerStyle.minimal:
        return theme.textTheme.bodyLarge?.color ?? Colors.black87;
      case TimerStyle.modern:
      case TimerStyle.gradient:
      case TimerStyle.neon:
      case TimerStyle.retro:
        return Colors.white;
    }
  }

  Widget _buildTimerDisplay() {
    return TimerDisplay(
      time: _formatTime(_remainingTime),
      progress: _getProgress(),
      style: widget.timer.style,
      primaryColor: widget.timer.primaryColor,
      secondaryColor: widget.timer.secondaryColor,
      isCompleted: _isCompleted,
      pulseController: _pulseController,
    );
  }

  Widget _buildControls() {
    return TimerControls(
      isRunning: _isRunning,
      isPaused: _isPaused,
      isCompleted: _isCompleted,
      style: widget.timer.style,
      primaryColor: widget.timer.primaryColor,
      secondaryColor: widget.timer.secondaryColor,
      onStart: _startTimer,
      onPause: _pauseTimer,
      onResume: _resumeTimer,
      onReset: _resetTimer,
    );
  }
}
