// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Super Chicken Timer';

  @override
  String get tabTimers => 'Minuteurs';

  @override
  String get tabTasks => 'Tâches';

  @override
  String get tabStatistics => 'Statistiques';

  @override
  String get tabSettings => 'Paramètres';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsPersonalize => 'Personnaliser l\'application';

  @override
  String get settingsTheme => 'Thème de l\'application';

  @override
  String get settingsThemeHint => 'Système, clair ou sombre';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsDarkModeHint => 'Utiliser le thème sombre';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsEnableNotifications => 'Activer les notifications';

  @override
  String get settingsEnableNotificationsHint => 'Recevoir des notifications de fin de minuteur';

  @override
  String get settingsSound => 'Notifications sonores';

  @override
  String get settingsSoundHint => 'Jouer un son à la fin';

  @override
  String get settingsVibration => 'Vibration';

  @override
  String get settingsVibrationHint => 'Vibrer à la fin du minuteur';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageHint => 'Choisissez votre langue préférée';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsDeveloper => 'Développeur';

  @override
  String get settingsLicense => 'Licence';

  @override
  String get settingsTeam => 'FRANCISCUS WILHELMUS VAN DORT';

  @override
  String get settingsMIT => 'Licence MIT';

  @override
  String get statisticsTitle => 'Statistiques';

  @override
  String get statisticsSubtitle => 'Suivez l\'utilisation de vos minuteurs';

  @override
  String get statisticsEmpty => 'Aucune donnée';

  @override
  String get statisticsEmptyDesc => 'Commencez à utiliser les minuteurs pour voir vos statistiques ici';

  @override
  String get todoTitle => 'Mes tâches';

  @override
  String todoCompleted(Object count, Object total) {
    return '$count sur $total terminées';
  }

  @override
  String get todoNoTasks => 'Aucune tâche';

  @override
  String get todoAddFirst => 'Ajoutez votre première tâche';

  @override
  String get todoAdd => 'Ajouter';

  @override
  String get todoEdit => 'Modifier la tâche';

  @override
  String get todoCancel => 'Annuler';

  @override
  String get todoSave => 'Enregistrer';

  @override
  String get todoNewTask => 'Nouvelle tâche';

  @override
  String get todoName => 'Nom';

  @override
  String get todoDescription => 'Description (optionnel)';

  @override
  String get todoTitleLabel => 'Titre de la tâche';

  @override
  String get todoDescriptionLabel => 'Description (optionnel)';

  @override
  String get todoTitleRequired => 'Le titre est requis';

  @override
  String get todoDeleteTitle => 'Supprimer la tâche';

  @override
  String get todoDeleteMessage => 'Êtes-vous sûr de vouloir supprimer cette tâche ?';

  @override
  String get todoClearCompleted => 'Effacer terminées';

  @override
  String get todoClearCompletedTitle => 'Effacer les tâches terminées';

  @override
  String todoClearCompletedMessage(Object count) {
    return 'Supprimer $count tâches terminées ?';
  }

  @override
  String get delete => 'Supprimer';

  @override
  String get clear => 'Effacer';

  @override
  String get timerPomodoro => 'Pomodoro';

  @override
  String get timerPomodoroDesc => '25 minutes de travail, 5 minutes de pause';

  @override
  String get timerChicken => 'Minuteur Poulet';

  @override
  String get timerChickenDesc => 'Cycles de travail et de pause personnalisables';

  @override
  String get chickenDescRoad => 'Minuteur pour travailler efficacement sur la route forestière. Ressentez la fraîcheur de la nature !';

  @override
  String get chickenDescFarm => 'Minuteur pour travailler et se reposer à la ferme. Inspirez-vous de l\'ambiance du village !';

  @override
  String get chickenDescMountain => 'Minuteur pour se concentrer parmi les montagnes et la nature. Atteignez de nouveaux sommets !';

  @override
  String get chickenDescClassic => 'Minuteur poulet classique pour travailler et se reposer efficacement.';

  @override
  String get chickenSettingsTitle => 'Paramètres du Minuteur Poulet';

  @override
  String get chickenWorkTime => 'Temps de travail';

  @override
  String get chickenBreakTime => 'Temps de pause';

  @override
  String get chickenLongBreakTime => 'Temps de pause longue';

  @override
  String get chickenSessionsBeforeLongBreak => 'Sessions avant la pause longue';

  @override
  String get chickenStart => 'Démarrer';

  @override
  String get chickenPause => 'Pause';

  @override
  String get chickenResume => 'Reprendre';

  @override
  String get chickenReset => 'Réinitialiser';

  @override
  String get chickenWork => 'Travail';

  @override
  String get chickenBreak => 'Pause';

  @override
  String get chickenWorkComplete => 'Travail terminé !';

  @override
  String get chickenBreakComplete => 'Pause terminée !';

  @override
  String get chickenWorkCompleteBody => 'Il est temps de faire une pause !';

  @override
  String get chickenBreakCompleteBody => 'Il est temps de reprendre le travail !';

  @override
  String get timerMeditation => 'Méditation';

  @override
  String get timerMeditationDesc => 'Calme et concentration';

  @override
  String get timerWorkout => 'Entraînement';

  @override
  String get timerWorkoutDesc => 'Entraînement intense';

  @override
  String get timerStudy => 'Étude';

  @override
  String get timerStudyDesc => 'Concentrez-vous sur l\'apprentissage';

  @override
  String get timerCountdown => 'Compte à rebours';

  @override
  String get timerCountdownDesc => 'Minuteur personnalisable';

  @override
  String get timerStopwatch => 'Chronomètre';

  @override
  String get timerStopwatchDesc => 'Mesure du temps';

  @override
  String get timerDone => 'Terminé !';

  @override
  String get timerFinished => 'Terminé !';

  @override
  String get timerFinishedTitle => 'Minuteur terminé !';

  @override
  String timerFinishedBody(Object timerName) {
    return '$timerName terminé';
  }

  @override
  String get sessionSavedTitle => 'Session enregistrée';

  @override
  String get sessionSavedBody => 'Session du minuteur enregistrée dans les statistiques';

  @override
  String get statisticsSelectMonth => 'Sélectionner le mois';

  @override
  String get cancel => 'Annuler';

  @override
  String get homeTitle => 'Super Chicken Timer';

  @override
  String get homeSubtitle => 'Choisissez votre minuteur';

  @override
  String todoProgress(Object done, Object total) {
    return '$done sur $total terminées';
  }

  @override
  String get todoEmpty => 'Aucune tâche';

  @override
  String get todoEmptyAdd => 'Ajoutez votre première tâche';

  @override
  String get todoNew => 'Nouvelle tâche';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get notificationChannelName => 'Notifications du minuteur';

  @override
  String get notificationChannelDescription => 'Notifications de fin de minuterie';

  @override
  String get timerNameForestRoad => 'Route forestière';

  @override
  String get timerNameChickenFarm => 'Ferme de poulets';

  @override
  String get timerNameChickenMountain => 'Montagne de poulets';

  @override
  String get languageRussian => 'Russe';

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get languageFrench => 'Français';

  @override
  String todoTimeMinutesAgo(Object minutes) {
    return 'il y a $minutes min';
  }

  @override
  String todoTimeHoursAgo(Object hours) {
    return 'il y a $hours h';
  }

  @override
  String get todoTimeYesterday => 'Hier';

  @override
  String todoTimeDaysAgo(Object days) {
    return 'il y a $days jours';
  }

  @override
  String get monthJan => 'Janv';

  @override
  String get monthFeb => 'Févr';

  @override
  String get monthMar => 'Mars';

  @override
  String get monthApr => 'Avr';

  @override
  String get monthMay => 'Mai';

  @override
  String get monthJun => 'Juin';

  @override
  String get monthJul => 'Juil';

  @override
  String get monthAug => 'Août';

  @override
  String get monthSep => 'Sept';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Déc';

  @override
  String get statTotalTime => 'Temps total';

  @override
  String get statSessions => 'Sessions';

  @override
  String get statCompleted => 'Terminé';
}
