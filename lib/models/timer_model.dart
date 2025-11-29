import 'package:flutter/material.dart';

enum TimerType {
  pomodoro,
  chicken,
  countdown,
  stopwatch,
  meditation,
  workout,
  study,
}

enum TimerStyle { classic, modern, gradient, neon, minimal, retro }

class TimerModel {
  final String id;
  final String name;
  final String description;
  final Duration duration;
  final TimerType type;
  final TimerStyle style;
  final String icon;
  final Color primaryColor;
  final Color secondaryColor;
  final String? background;
  final bool isFavorite;

  TimerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.type,
    required this.style,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    this.background,
    this.isFavorite = false,
  });

  TimerModel copyWith({
    String? id,
    String? name,
    String? description,
    Duration? duration,
    TimerType? type,
    TimerStyle? style,
    String? icon,
    Color? primaryColor,
    Color? secondaryColor,
    String? background,
    bool? isFavorite,
  }) {
    return TimerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      style: style ?? this.style,
      icon: icon ?? this.icon,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      background: background ?? this.background,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class ChickenTimerSettings {
  final Duration workDuration;
  final Duration breakDuration;
  final int sessionsBeforeLongBreak;
  final Duration longBreakDuration;

  ChickenTimerSettings({
    this.workDuration = const Duration(minutes: 25),
    this.breakDuration = const Duration(minutes: 5),
    this.sessionsBeforeLongBreak = 4,
    this.longBreakDuration = const Duration(minutes: 15),
  });

  ChickenTimerSettings copyWith({
    Duration? workDuration,
    Duration? breakDuration,
    int? sessionsBeforeLongBreak,
    Duration? longBreakDuration,
  }) {
    return ChickenTimerSettings(
      workDuration: workDuration ?? this.workDuration,
      breakDuration: breakDuration ?? this.breakDuration,
      sessionsBeforeLongBreak:
          sessionsBeforeLongBreak ?? this.sessionsBeforeLongBreak,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
    );
  }
}

class TodoItem {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
  });

  TodoItem copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
