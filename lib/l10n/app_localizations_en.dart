// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Super Chicken Timer';

  @override
  String get tabTimers => 'Timers';

  @override
  String get tabTasks => 'Tasks';

  @override
  String get tabStatistics => 'Statistics';

  @override
  String get tabSettings => 'Settings';

  @override
  String get settings => 'Settings';

  @override
  String get settingsPersonalize => 'Personalize the app';

  @override
  String get settingsTheme => 'App Theme';

  @override
  String get settingsThemeHint => 'System, light or dark';

  @override
  String get settingsDarkMode => 'Dark mode';

  @override
  String get settingsDarkModeHint => 'Use dark theme';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsEnableNotifications => 'Enable notifications';

  @override
  String get settingsEnableNotificationsHint => 'Get timer completion notifications';

  @override
  String get settingsSound => 'Sound notifications';

  @override
  String get settingsSoundHint => 'Play sound on completion';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsVibrationHint => 'Vibrate on timer completion';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageHint => 'Choose your preferred language';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsDeveloper => 'Developer';

  @override
  String get settingsLicense => 'License';

  @override
  String get settingsTeam => 'FRANCISCUS WILHELMUS VAN DORT';

  @override
  String get settingsMIT => 'MIT License';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get statisticsSubtitle => 'Track your timer usage';

  @override
  String get statisticsEmpty => 'No data';

  @override
  String get statisticsEmptyDesc => 'Start using timers to see your statistics here';

  @override
  String get todoTitle => 'My Tasks';

  @override
  String todoCompleted(Object count, Object total) {
    return '$count of $total completed';
  }

  @override
  String get todoNoTasks => 'No tasks';

  @override
  String get todoAddFirst => 'Add your first task';

  @override
  String get todoAdd => 'Add';

  @override
  String get todoEdit => 'Edit Task';

  @override
  String get todoCancel => 'Cancel';

  @override
  String get todoSave => 'Save';

  @override
  String get todoNewTask => 'New Task';

  @override
  String get todoName => 'Name';

  @override
  String get todoDescription => 'Description (optional)';

  @override
  String get todoTitleLabel => 'Task title';

  @override
  String get todoDescriptionLabel => 'Description (optional)';

  @override
  String get todoTitleRequired => 'Title is required';

  @override
  String get todoDeleteTitle => 'Delete Task';

  @override
  String get todoDeleteMessage => 'Are you sure you want to delete this task?';

  @override
  String get todoClearCompleted => 'Clear completed';

  @override
  String get todoClearCompletedTitle => 'Clear Completed Tasks';

  @override
  String todoClearCompletedMessage(Object count) {
    return 'Delete $count completed tasks?';
  }

  @override
  String get delete => 'Delete';

  @override
  String get clear => 'Clear';

  @override
  String get timerPomodoro => 'Pomodoro';

  @override
  String get timerPomodoroDesc => '25 minutes work, 5 minutes break';

  @override
  String get timerChicken => 'Chicken Timer';

  @override
  String get timerChickenDesc => 'Customizable work and break cycles';

  @override
  String get chickenDescRoad => 'A timer for productive work on a forest road. Feel the freshness of nature!';

  @override
  String get chickenDescFarm => 'A timer for work and rest on the farm. Get inspired by the village atmosphere!';

  @override
  String get chickenDescMountain => 'A timer for focus among mountains and nature. Reach new heights!';

  @override
  String get chickenDescClassic => 'Classic chicken timer for effective work and rest.';

  @override
  String get chickenSettingsTitle => 'Chicken Timer Settings';

  @override
  String get chickenWorkTime => 'Work Time';

  @override
  String get chickenBreakTime => 'Break Time';

  @override
  String get chickenLongBreakTime => 'Long Break Time';

  @override
  String get chickenSessionsBeforeLongBreak => 'Sessions before long break';

  @override
  String get chickenStart => 'Start';

  @override
  String get chickenPause => 'Pause';

  @override
  String get chickenResume => 'Resume';

  @override
  String get chickenReset => 'Reset';

  @override
  String get chickenWork => 'Work';

  @override
  String get chickenBreak => 'Break';

  @override
  String get chickenWorkComplete => 'Work Complete!';

  @override
  String get chickenBreakComplete => 'Break Complete!';

  @override
  String get chickenWorkCompleteBody => 'Time to take a break!';

  @override
  String get chickenBreakCompleteBody => 'Time to get back to work!';

  @override
  String get timerMeditation => 'Meditation';

  @override
  String get timerMeditationDesc => 'Calm and focus';

  @override
  String get timerWorkout => 'Workout';

  @override
  String get timerWorkoutDesc => 'Intense workout';

  @override
  String get timerStudy => 'Study';

  @override
  String get timerStudyDesc => 'Focus on learning';

  @override
  String get timerCountdown => 'Countdown';

  @override
  String get timerCountdownDesc => 'Customizable timer';

  @override
  String get timerStopwatch => 'Stopwatch';

  @override
  String get timerStopwatchDesc => 'Time measurement';

  @override
  String get timerDone => 'Done!';

  @override
  String get timerFinished => 'Finished!';

  @override
  String get timerFinishedTitle => 'Timer finished!';

  @override
  String timerFinishedBody(Object timerName) {
    return '$timerName finished';
  }

  @override
  String get sessionSavedTitle => 'Session saved';

  @override
  String get sessionSavedBody => 'Timer session saved to statistics';

  @override
  String get statisticsSelectMonth => 'Select month';

  @override
  String get cancel => 'Cancel';

  @override
  String get homeTitle => 'Super Chicken Timer';

  @override
  String get homeSubtitle => 'Choose your timer';

  @override
  String todoProgress(Object done, Object total) {
    return '$done of $total completed';
  }

  @override
  String get todoEmpty => 'No tasks';

  @override
  String get todoEmptyAdd => 'Add your first task';

  @override
  String get todoNew => 'New Task';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get notificationChannelName => 'Timer Notifications';

  @override
  String get notificationChannelDescription => 'Notifications for timer completion';

  @override
  String get timerNameForestRoad => 'Forest Road';

  @override
  String get timerNameChickenFarm => 'Chicken Farm';

  @override
  String get timerNameChickenMountain => 'Chicken Mountain';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageFrench => 'French';

  @override
  String todoTimeMinutesAgo(Object minutes) {
    return '$minutes min ago';
  }

  @override
  String todoTimeHoursAgo(Object hours) {
    return '$hours h ago';
  }

  @override
  String get todoTimeYesterday => 'Yesterday';

  @override
  String todoTimeDaysAgo(Object days) {
    return '$days days ago';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get statTotalTime => 'Total time';

  @override
  String get statSessions => 'Sessions';

  @override
  String get statCompleted => 'Completed';
}
