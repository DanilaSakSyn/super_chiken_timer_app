import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/timer_model.dart';
import '../services/notification_service.dart';
import '../services/statistics_service.dart';
import '../l10n/app_localizations.dart';

class ChickenTimerScreen extends StatefulWidget {
  final TimerModel timer;

  const ChickenTimerScreen({super.key, required this.timer});

  @override
  State<ChickenTimerScreen> createState() => _ChickenTimerScreenState();
}

class _ChickenTimerScreenState extends State<ChickenTimerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  Timer? _timer;

  ChickenTimerSettings _settings = ChickenTimerSettings();
  bool _isSettingsMode = true;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isWorkTime = true;
  int _currentSession = 1;

  Duration _remainingTime = const Duration(minutes: 25);
  DateTime? _sessionStartTime;
  String? _sessionId;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _remainingTime = _settings.workDuration;
  }

  @override
  void dispose() {
    if (_isRunning || _isPaused) {
      _saveSession(false);
    }
    _timer?.cancel();
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (_isSettingsMode) {
      setState(() {
        _isSettingsMode = false;
        _isWorkTime = true;
        _currentSession = 1;
        _remainingTime = _settings.workDuration;
      });
    }

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
          _completePhase();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    _timer?.cancel();
    _saveSession(false);
  }

  void _resumeTimer() {
    _startTimer();
  }

  void _resetTimer() {
    if (_isRunning || _isPaused) {
      _saveSession(false);
    }

    setState(() {
      _isRunning = false;
      _isPaused = false;
      _isSettingsMode = true;
      _isWorkTime = true;
      _currentSession = 1;
      _remainingTime = _settings.workDuration;
      _sessionStartTime = null;
      _sessionId = null;
    });
    _timer?.cancel();
    _pulseController.reset();
  }

  void _completePhase() {
    _timer?.cancel();

    if (_isWorkTime) {
      // Завершилось время работы
      _saveSession(true);
      _showPhaseCompleteNotification(true);

      if (_currentSession % _settings.sessionsBeforeLongBreak == 0) {
        // Длинный перерыв
        setState(() {
          _isWorkTime = false;
          _remainingTime = _settings.longBreakDuration;
        });
      } else {
        // Короткий перерыв
        setState(() {
          _isWorkTime = false;
          _remainingTime = _settings.breakDuration;
        });
      }
    } else {
      // Завершилось время перерыва
      _showPhaseCompleteNotification(false);

      setState(() {
        _isWorkTime = true;
        _currentSession++;
        _remainingTime = _settings.workDuration;
      });
    }

    setState(() {
      _isRunning = false;
      _isPaused = false;
    });

    _pulseController.repeat();
  }

  void _showPhaseCompleteNotification(bool isWorkComplete) {
    final loc = AppLocalizations.of(context)!;
    final title = isWorkComplete
        ? loc.chickenWorkComplete
        : loc.chickenBreakComplete;
    final body = isWorkComplete
        ? loc.chickenWorkCompleteBody
        : loc.chickenBreakCompleteBody;

    NotificationService().showTimerNotification(
      title: title,
      body: body,
      id: int.parse(widget.timer.id) + (_isWorkTime ? 0 : 100),
      channelName: loc.notificationChannelName,
      channelDescription: loc.notificationChannelDescription,
    );
  }

  void _saveSession(bool isCompleted) {
    if (_sessionStartTime == null || _sessionId == null) return;

    final statsService = Provider.of<StatisticsService>(context, listen: false);
    final endTime = DateTime.now();
    final sessionDuration = _settings.workDuration - _remainingTime;

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
    final totalTime = _isWorkTime
        ? _settings.workDuration
        : (_currentSession % _settings.sessionsBeforeLongBreak == 0
              ? _settings.longBreakDuration
              : _settings.breakDuration);

    if (totalTime.inSeconds == 0) return 0.0;

    final elapsed = totalTime.inSeconds - _remainingTime.inSeconds;
    return elapsed / totalTime.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    String? chickenBack;
    if (widget.timer.type == TimerType.chicken) {
      if (widget.timer.description ==
          AppLocalizations.of(context)!.chickenDescRoad) {
        chickenBack = 'assets/images/road_chicken_timer_back.webp';
      } else if (widget.timer.description ==
          AppLocalizations.of(context)!.chickenDescFarm) {
        chickenBack = 'assets/images/chicken_timer_back.webp';
      } else if (widget.timer.description ==
          AppLocalizations.of(context)!.chickenDescMountain) {
        chickenBack = 'assets/images/chicken_timer_back2.webp';
      } else {
        chickenBack = 'assets/images/farm_chicken_timer_back.webp';
      }
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.timer.type == TimerType.chicken && chickenBack != null
              ? DecorationImage(
                  image: AssetImage(chickenBack),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _isSettingsMode
                    ? _buildSettingsView()
                    : _buildTimerView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (_isRunning || _isPaused) {
                _saveSession(false);
              }
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
          ),
          Expanded(
            child: Text(
              widget.timer.name,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildSettingsView() {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            loc.chickenSettingsTitle,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 30),
          _buildSettingCard(
            title: loc.chickenWorkTime,
            duration: _settings.workDuration,
            onChanged: (duration) {
              setState(() {
                _settings = _settings.copyWith(workDuration: duration);
                _remainingTime = duration;
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSettingCard(
            title: loc.chickenBreakTime,
            duration: _settings.breakDuration,
            onChanged: (duration) {
              setState(() {
                _settings = _settings.copyWith(breakDuration: duration);
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSettingCard(
            title: loc.chickenLongBreakTime,
            duration: _settings.longBreakDuration,
            onChanged: (duration) {
              setState(() {
                _settings = _settings.copyWith(longBreakDuration: duration);
              });
            },
          ),
          const SizedBox(height: 20),
          _buildSessionsSetting(),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _startTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                loc.chickenStart,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required Duration duration,
    required Function(Duration) onChanged,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  final newMinutes = (duration.inMinutes - 1).clamp(1, 60);
                  onChanged(Duration(minutes: newMinutes));
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: theme.iconTheme.color,
              ),
              Text(
                '${duration.inMinutes} min',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  final newMinutes = (duration.inMinutes + 1).clamp(1, 60);
                  onChanged(Duration(minutes: newMinutes));
                },
                icon: const Icon(Icons.add_circle_outline),
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsSetting() {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              loc.chickenSessionsBeforeLongBreak,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  final newSessions = (_settings.sessionsBeforeLongBreak - 1)
                      .clamp(1, 10);
                  setState(() {
                    _settings = _settings.copyWith(
                      sessionsBeforeLongBreak: newSessions,
                    );
                  });
                },
                icon: const Icon(Icons.remove_circle_outline),
                color: theme.iconTheme.color,
              ),
              Text(
                '${_settings.sessionsBeforeLongBreak}',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  final newSessions = (_settings.sessionsBeforeLongBreak + 1)
                      .clamp(1, 10);
                  setState(() {
                    _settings = _settings.copyWith(
                      sessionsBeforeLongBreak: newSessions,
                    );
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerView() {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Индикатор фазы
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: _isWorkTime
                  ? theme.colorScheme.primary.withOpacity(0.8)
                  : theme.colorScheme.secondary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _isWorkTime
                  ? '${loc.chickenWork} $_currentSession'
                  : loc.chickenBreak,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Таймер
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.cardColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Прогресс
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: _getProgress(),
                      strokeWidth: 8,
                      backgroundColor: theme.dividerColor.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _isWorkTime
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                // Время
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatTime(_remainingTime),
                        style: GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color:
                              theme.textTheme.bodyLarge?.color ??
                              Colors.black87,
                        ),
                      ),
                      Text(
                        _isWorkTime ? loc.chickenWork : loc.chickenBreak,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color:
                              theme.textTheme.bodyMedium?.color ??
                              Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Кнопки управления
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!_isRunning && !_isPaused)
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceVariant
                        .withOpacity(0.8),
                    foregroundColor: theme.colorScheme.onSurface,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(loc.chickenReset),
                ),

              if (_isRunning)
                ElevatedButton(
                  onPressed: _pauseTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.tertiary.withOpacity(
                      0.8,
                    ),
                    foregroundColor: theme.colorScheme.onTertiary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(loc.chickenPause),
                ),

              if (_isPaused)
                ElevatedButton(
                  onPressed: _resumeTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary.withOpacity(
                      0.8,
                    ),
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(loc.chickenResume),
                ),

              if (!_isRunning && !_isPaused)
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(loc.chickenStart),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
