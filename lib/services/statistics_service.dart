import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/timer_model.dart';

class TimerSession {
  final String id;
  final String timerId;
  final String timerName;
  final TimerType timerType;
  final Duration duration;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  TimerSession({
    required this.id,
    required this.timerId,
    required this.timerName,
    required this.timerType,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timerId': timerId,
      'timerName': timerName,
      'timerType': timerType.index,
      'duration': duration.inSeconds,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory TimerSession.fromJson(Map<String, dynamic> json) {
    return TimerSession(
      id: json['id'],
      timerId: json['timerId'],
      timerName: json['timerName'],
      timerType: TimerType.values[json['timerType']],
      duration: Duration(seconds: json['duration']),
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

class TimerStatistics {
  final String timerId;
  final String timerName;
  final TimerType timerType;
  final Duration totalTime;
  final int sessionsCount;
  final int completedSessions;

  TimerStatistics({
    required this.timerId,
    required this.timerName,
    required this.timerType,
    required this.totalTime,
    required this.sessionsCount,
    required this.completedSessions,
  });
}

class StatisticsService extends ChangeNotifier {
  static const String _sessionsKey = 'timer_sessions';
  List<TimerSession> _sessions = [];

  List<TimerSession> get sessions => List.unmodifiable(_sessions);

  StatisticsService() {
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionsJson = prefs.getStringList(_sessionsKey) ?? [];

      _sessions = sessionsJson
          .map((json) => TimerSession.fromJson(jsonDecode(json)))
          .toList();

      // Сортируем по времени начала (новые сверху)
      _sessions.sort((a, b) => b.startTime.compareTo(a.startTime));

      notifyListeners();
    } catch (e) {
      debugPrint('Error loading sessions: $e');
    }
  }

  Future<void> _saveSessions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionsJson = _sessions
          .map((session) => jsonEncode(session.toJson()))
          .toList();

      await prefs.setStringList(_sessionsKey, sessionsJson);
    } catch (e) {
      debugPrint('Error saving sessions: $e');
    }
  }

  Future<void> addSession(TimerSession session) async {
    _sessions.insert(0, session);
    await _saveSessions();
    notifyListeners();
  }

  Future<void> updateSession(String sessionId, bool isCompleted) async {
    final index = _sessions.indexWhere((session) => session.id == sessionId);
    if (index != -1) {
      final session = _sessions[index];
      _sessions[index] = TimerSession(
        id: session.id,
        timerId: session.timerId,
        timerName: session.timerName,
        timerType: session.timerType,
        duration: session.duration,
        startTime: session.startTime,
        endTime: session.endTime,
        isCompleted: isCompleted,
      );
      await _saveSessions();
      notifyListeners();
    }
  }

  Future<void> deleteSession(String sessionId) async {
    _sessions.removeWhere((session) => session.id == sessionId);
    await _saveSessions();
    notifyListeners();
  }

  Future<void> clearAllSessions() async {
    _sessions.clear();
    await _saveSessions();
    notifyListeners();
  }

  List<TimerSession> getSessionsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0, 23, 59, 59);

    return _sessions.where((session) {
      return session.startTime.isAfter(
            startOfMonth.subtract(const Duration(seconds: 1)),
          ) &&
          session.startTime.isBefore(
            endOfMonth.add(const Duration(seconds: 1)),
          );
    }).toList();
  }

  List<TimerStatistics> getStatisticsForMonth(DateTime month) {
    final sessions = getSessionsForMonth(month);
    final Map<String, TimerStatistics> statsMap = {};

    for (final session in sessions) {
      if (statsMap.containsKey(session.timerId)) {
        final existing = statsMap[session.timerId]!;
        statsMap[session.timerId] = TimerStatistics(
          timerId: existing.timerId,
          timerName: existing.timerName,
          timerType: existing.timerType,
          totalTime: existing.totalTime + session.duration,
          sessionsCount: existing.sessionsCount + 1,
          completedSessions:
              existing.completedSessions + (session.isCompleted ? 1 : 0),
        );
      } else {
        statsMap[session.timerId] = TimerStatistics(
          timerId: session.timerId,
          timerName: session.timerName,
          timerType: session.timerType,
          totalTime: session.duration,
          sessionsCount: 1,
          completedSessions: session.isCompleted ? 1 : 0,
        );
      }
    }

    return statsMap.values.toList()
      ..sort((a, b) => b.totalTime.compareTo(a.totalTime));
  }

  Duration getTotalTimeForMonth(DateTime month) {
    final sessions = getSessionsForMonth(month);
    return sessions.fold(
      Duration.zero,
      (total, session) => total + session.duration,
    );
  }

  int getTotalSessionsForMonth(DateTime month) {
    return getSessionsForMonth(month).length;
  }

  int getCompletedSessionsForMonth(DateTime month) {
    return getSessionsForMonth(
      month,
    ).where((session) => session.isCompleted).length;
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (hours > 0) {
      return '${hours}ч ${minutes}м ${seconds}с';
    } else if (minutes > 0) {
      return '${minutes}м ${seconds}с';
    } else {
      return '${seconds}с';
    }
  }

  String getMonthName(DateTime month) {
    const months = [
      'Январь',
      'Февраль',
      'Март',
      'Апрель',
      'Май',
      'Июнь',
      'Июль',
      'Август',
      'Сентябрь',
      'Октябрь',
      'Ноябрь',
      'Декабрь',
    ];
    return months[month.month - 1];
  }
}
