import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ru')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Super Chicken Timer'**
  String get appTitle;

  /// No description provided for @tabTimers.
  ///
  /// In en, this message translates to:
  /// **'Timers'**
  String get tabTimers;

  /// No description provided for @tabTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tabTasks;

  /// No description provided for @tabStatistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get tabStatistics;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsPersonalize.
  ///
  /// In en, this message translates to:
  /// **'Personalize the app'**
  String get settingsPersonalize;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeHint.
  ///
  /// In en, this message translates to:
  /// **'System, light or dark'**
  String get settingsThemeHint;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsDarkModeHint.
  ///
  /// In en, this message translates to:
  /// **'Use dark theme'**
  String get settingsDarkModeHint;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsEnableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get settingsEnableNotifications;

  /// No description provided for @settingsEnableNotificationsHint.
  ///
  /// In en, this message translates to:
  /// **'Get timer completion notifications'**
  String get settingsEnableNotificationsHint;

  /// No description provided for @settingsSound.
  ///
  /// In en, this message translates to:
  /// **'Sound notifications'**
  String get settingsSound;

  /// No description provided for @settingsSoundHint.
  ///
  /// In en, this message translates to:
  /// **'Play sound on completion'**
  String get settingsSoundHint;

  /// No description provided for @settingsVibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsVibrationHint.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on timer completion'**
  String get settingsVibrationHint;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get settingsLanguageHint;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsDeveloper;

  /// No description provided for @settingsLicense.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get settingsLicense;

  /// No description provided for @settingsTeam.
  ///
  /// In en, this message translates to:
  /// **'FRANCISCUS WILHELMUS VAN DORT'**
  String get settingsTeam;

  /// No description provided for @settingsMIT.
  ///
  /// In en, this message translates to:
  /// **'MIT License'**
  String get settingsMIT;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTitle;

  /// No description provided for @statisticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your timer usage'**
  String get statisticsSubtitle;

  /// No description provided for @statisticsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get statisticsEmpty;

  /// No description provided for @statisticsEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Start using timers to see your statistics here'**
  String get statisticsEmptyDesc;

  /// No description provided for @todoTitle.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get todoTitle;

  /// No description provided for @todoCompleted.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} completed'**
  String todoCompleted(Object count, Object total);

  /// No description provided for @todoNoTasks.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get todoNoTasks;

  /// No description provided for @todoAddFirst.
  ///
  /// In en, this message translates to:
  /// **'Add your first task'**
  String get todoAddFirst;

  /// No description provided for @todoAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get todoAdd;

  /// No description provided for @todoEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get todoEdit;

  /// No description provided for @todoCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get todoCancel;

  /// No description provided for @todoSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get todoSave;

  /// No description provided for @todoNewTask.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get todoNewTask;

  /// No description provided for @todoName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get todoName;

  /// No description provided for @todoDescription.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get todoDescription;

  /// No description provided for @todoTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get todoTitleLabel;

  /// No description provided for @todoDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get todoDescriptionLabel;

  /// No description provided for @todoTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get todoTitleRequired;

  /// No description provided for @todoDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get todoDeleteTitle;

  /// No description provided for @todoDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this task?'**
  String get todoDeleteMessage;

  /// No description provided for @todoClearCompleted.
  ///
  /// In en, this message translates to:
  /// **'Clear completed'**
  String get todoClearCompleted;

  /// No description provided for @todoClearCompletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Completed Tasks'**
  String get todoClearCompletedTitle;

  /// No description provided for @todoClearCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} completed tasks?'**
  String todoClearCompletedMessage(Object count);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @timerPomodoro.
  ///
  /// In en, this message translates to:
  /// **'Pomodoro'**
  String get timerPomodoro;

  /// No description provided for @timerPomodoroDesc.
  ///
  /// In en, this message translates to:
  /// **'25 minutes work, 5 minutes break'**
  String get timerPomodoroDesc;

  /// No description provided for @timerChicken.
  ///
  /// In en, this message translates to:
  /// **'Chicken Timer'**
  String get timerChicken;

  /// No description provided for @timerChickenDesc.
  ///
  /// In en, this message translates to:
  /// **'Customizable work and break cycles'**
  String get timerChickenDesc;

  /// No description provided for @chickenDescRoad.
  ///
  /// In en, this message translates to:
  /// **'A timer for productive work on a forest road. Feel the freshness of nature!'**
  String get chickenDescRoad;

  /// No description provided for @chickenDescFarm.
  ///
  /// In en, this message translates to:
  /// **'A timer for work and rest on the farm. Get inspired by the village atmosphere!'**
  String get chickenDescFarm;

  /// No description provided for @chickenDescMountain.
  ///
  /// In en, this message translates to:
  /// **'A timer for focus among mountains and nature. Reach new heights!'**
  String get chickenDescMountain;

  /// No description provided for @chickenDescClassic.
  ///
  /// In en, this message translates to:
  /// **'Classic chicken timer for effective work and rest.'**
  String get chickenDescClassic;

  /// No description provided for @chickenSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Chicken Timer Settings'**
  String get chickenSettingsTitle;

  /// No description provided for @chickenWorkTime.
  ///
  /// In en, this message translates to:
  /// **'Work Time'**
  String get chickenWorkTime;

  /// No description provided for @chickenBreakTime.
  ///
  /// In en, this message translates to:
  /// **'Break Time'**
  String get chickenBreakTime;

  /// No description provided for @chickenLongBreakTime.
  ///
  /// In en, this message translates to:
  /// **'Long Break Time'**
  String get chickenLongBreakTime;

  /// No description provided for @chickenSessionsBeforeLongBreak.
  ///
  /// In en, this message translates to:
  /// **'Sessions before long break'**
  String get chickenSessionsBeforeLongBreak;

  /// No description provided for @chickenStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get chickenStart;

  /// No description provided for @chickenPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get chickenPause;

  /// No description provided for @chickenResume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get chickenResume;

  /// No description provided for @chickenReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get chickenReset;

  /// No description provided for @chickenWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get chickenWork;

  /// No description provided for @chickenBreak.
  ///
  /// In en, this message translates to:
  /// **'Break'**
  String get chickenBreak;

  /// No description provided for @chickenWorkComplete.
  ///
  /// In en, this message translates to:
  /// **'Work Complete!'**
  String get chickenWorkComplete;

  /// No description provided for @chickenBreakComplete.
  ///
  /// In en, this message translates to:
  /// **'Break Complete!'**
  String get chickenBreakComplete;

  /// No description provided for @chickenWorkCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'Time to take a break!'**
  String get chickenWorkCompleteBody;

  /// No description provided for @chickenBreakCompleteBody.
  ///
  /// In en, this message translates to:
  /// **'Time to get back to work!'**
  String get chickenBreakCompleteBody;

  /// No description provided for @timerMeditation.
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get timerMeditation;

  /// No description provided for @timerMeditationDesc.
  ///
  /// In en, this message translates to:
  /// **'Calm and focus'**
  String get timerMeditationDesc;

  /// No description provided for @timerWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get timerWorkout;

  /// No description provided for @timerWorkoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Intense workout'**
  String get timerWorkoutDesc;

  /// No description provided for @timerStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get timerStudy;

  /// No description provided for @timerStudyDesc.
  ///
  /// In en, this message translates to:
  /// **'Focus on learning'**
  String get timerStudyDesc;

  /// No description provided for @timerCountdown.
  ///
  /// In en, this message translates to:
  /// **'Countdown'**
  String get timerCountdown;

  /// No description provided for @timerCountdownDesc.
  ///
  /// In en, this message translates to:
  /// **'Customizable timer'**
  String get timerCountdownDesc;

  /// No description provided for @timerStopwatch.
  ///
  /// In en, this message translates to:
  /// **'Stopwatch'**
  String get timerStopwatch;

  /// No description provided for @timerStopwatchDesc.
  ///
  /// In en, this message translates to:
  /// **'Time measurement'**
  String get timerStopwatchDesc;

  /// No description provided for @timerDone.
  ///
  /// In en, this message translates to:
  /// **'Done!'**
  String get timerDone;

  /// No description provided for @timerFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished!'**
  String get timerFinished;

  /// No description provided for @timerFinishedTitle.
  ///
  /// In en, this message translates to:
  /// **'Timer finished!'**
  String get timerFinishedTitle;

  /// No description provided for @timerFinishedBody.
  ///
  /// In en, this message translates to:
  /// **'{timerName} finished'**
  String timerFinishedBody(Object timerName);

  /// No description provided for @sessionSavedTitle.
  ///
  /// In en, this message translates to:
  /// **'Session saved'**
  String get sessionSavedTitle;

  /// No description provided for @sessionSavedBody.
  ///
  /// In en, this message translates to:
  /// **'Timer session saved to statistics'**
  String get sessionSavedBody;

  /// No description provided for @statisticsSelectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select month'**
  String get statisticsSelectMonth;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Super Chicken Timer'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your timer'**
  String get homeSubtitle;

  /// No description provided for @todoProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} completed'**
  String todoProgress(Object done, Object total);

  /// No description provided for @todoEmpty.
  ///
  /// In en, this message translates to:
  /// **'No tasks'**
  String get todoEmpty;

  /// No description provided for @todoEmptyAdd.
  ///
  /// In en, this message translates to:
  /// **'Add your first task'**
  String get todoEmptyAdd;

  /// No description provided for @todoNew.
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get todoNew;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @notificationChannelName.
  ///
  /// In en, this message translates to:
  /// **'Timer Notifications'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In en, this message translates to:
  /// **'Notifications for timer completion'**
  String get notificationChannelDescription;

  /// No description provided for @timerNameForestRoad.
  ///
  /// In en, this message translates to:
  /// **'Forest Road'**
  String get timerNameForestRoad;

  /// No description provided for @timerNameChickenFarm.
  ///
  /// In en, this message translates to:
  /// **'Chicken Farm'**
  String get timerNameChickenFarm;

  /// No description provided for @timerNameChickenMountain.
  ///
  /// In en, this message translates to:
  /// **'Chicken Mountain'**
  String get timerNameChickenMountain;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @todoTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String todoTimeMinutesAgo(Object minutes);

  /// No description provided for @todoTimeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} h ago'**
  String todoTimeHoursAgo(Object hours);

  /// No description provided for @todoTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get todoTimeYesterday;

  /// No description provided for @todoTimeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String todoTimeDaysAgo(Object days);

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;

  /// No description provided for @statTotalTime.
  ///
  /// In en, this message translates to:
  /// **'Total time'**
  String get statTotalTime;

  /// No description provided for @statSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get statSessions;

  /// No description provided for @statCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statCompleted;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
