// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Super Chicken Timer';

  @override
  String get tabTimers => 'Temporizadores';

  @override
  String get tabTasks => 'Tareas';

  @override
  String get tabStatistics => 'Estadísticas';

  @override
  String get tabSettings => 'Configuración';

  @override
  String get settings => 'Configuración';

  @override
  String get settingsPersonalize => 'Personalizar la aplicación';

  @override
  String get settingsTheme => 'Tema de la aplicación';

  @override
  String get settingsThemeHint => 'Sistema, claro u oscuro';

  @override
  String get settingsDarkMode => 'Modo oscuro';

  @override
  String get settingsDarkModeHint => 'Usar tema oscuro';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsEnableNotifications => 'Habilitar notificaciones';

  @override
  String get settingsEnableNotificationsHint => 'Recibir notificaciones de finalización del temporizador';

  @override
  String get settingsSound => 'Notificaciones de sonido';

  @override
  String get settingsSoundHint => 'Reproducir sonido al finalizar';

  @override
  String get settingsVibration => 'Vibración';

  @override
  String get settingsVibrationHint => 'Vibrar al finalizar el temporizador';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageHint => 'Elige tu idioma preferido';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsVersion => 'Versión';

  @override
  String get settingsDeveloper => 'Desarrollador';

  @override
  String get settingsLicense => 'Licencia';

  @override
  String get settingsTeam => 'FRANCISCUS WILHELMUS VAN DORT';

  @override
  String get settingsMIT => 'Licencia MIT';

  @override
  String get statisticsTitle => 'Estadísticas';

  @override
  String get statisticsSubtitle => 'Rastrea el uso de tus temporizadores';

  @override
  String get statisticsEmpty => 'Sin datos';

  @override
  String get statisticsEmptyDesc => 'Comienza a usar temporizadores para ver tus estadísticas aquí';

  @override
  String get todoTitle => 'Mis tareas';

  @override
  String todoCompleted(Object count, Object total) {
    return '$count de $total completadas';
  }

  @override
  String get todoNoTasks => 'Sin tareas';

  @override
  String get todoAddFirst => 'Añade tu primera tarea';

  @override
  String get todoAdd => 'Añadir';

  @override
  String get todoEdit => 'Editar tarea';

  @override
  String get todoCancel => 'Cancelar';

  @override
  String get todoSave => 'Guardar';

  @override
  String get todoNewTask => 'Nueva tarea';

  @override
  String get todoName => 'Nombre';

  @override
  String get todoDescription => 'Descripción (opcional)';

  @override
  String get todoTitleLabel => 'Título de la tarea';

  @override
  String get todoDescriptionLabel => 'Descripción (opcional)';

  @override
  String get todoTitleRequired => 'El título es obligatorio';

  @override
  String get todoDeleteTitle => 'Eliminar tarea';

  @override
  String get todoDeleteMessage => '¿Estás seguro de que quieres eliminar esta tarea?';

  @override
  String get todoClearCompleted => 'Limpiar completadas';

  @override
  String get todoClearCompletedTitle => 'Limpiar tareas completadas';

  @override
  String todoClearCompletedMessage(Object count) {
    return '¿Eliminar $count tareas completadas?';
  }

  @override
  String get delete => 'Eliminar';

  @override
  String get clear => 'Limpiar';

  @override
  String get timerPomodoro => 'Pomodoro';

  @override
  String get timerPomodoroDesc => '25 minutos de trabajo, 5 minutos de descanso';

  @override
  String get timerChicken => 'Temporizador Pollo';

  @override
  String get timerChickenDesc => 'Ciclos de trabajo y descanso personalizables';

  @override
  String get chickenDescRoad => 'Temporizador para trabajar productivamente en el camino del bosque. ¡Siente la frescura de la naturaleza!';

  @override
  String get chickenDescFarm => 'Temporizador para trabajar y descansar en la granja. ¡Inspírate con el ambiente rural!';

  @override
  String get chickenDescMountain => 'Temporizador para concentrarse entre montañas y naturaleza. ¡Alcanza nuevas alturas!';

  @override
  String get chickenDescClassic => 'Temporizador clásico de pollo para trabajar y descansar eficazmente.';

  @override
  String get chickenSettingsTitle => 'Configuración del Temporizador Pollo';

  @override
  String get chickenWorkTime => 'Tiempo de trabajo';

  @override
  String get chickenBreakTime => 'Tiempo de descanso';

  @override
  String get chickenLongBreakTime => 'Tiempo de descanso largo';

  @override
  String get chickenSessionsBeforeLongBreak => 'Sesiones antes del descanso largo';

  @override
  String get chickenStart => 'Iniciar';

  @override
  String get chickenPause => 'Pausar';

  @override
  String get chickenResume => 'Reanudar';

  @override
  String get chickenReset => 'Reiniciar';

  @override
  String get chickenWork => 'Trabajo';

  @override
  String get chickenBreak => 'Descanso';

  @override
  String get chickenWorkComplete => '¡Trabajo completado!';

  @override
  String get chickenBreakComplete => '¡Descanso completado!';

  @override
  String get chickenWorkCompleteBody => '¡Hora de tomar un descanso!';

  @override
  String get chickenBreakCompleteBody => '¡Hora de volver al trabajo!';

  @override
  String get timerMeditation => 'Meditación';

  @override
  String get timerMeditationDesc => 'Calma y concentración';

  @override
  String get timerWorkout => 'Entrenamiento';

  @override
  String get timerWorkoutDesc => 'Entrenamiento intenso';

  @override
  String get timerStudy => 'Estudio';

  @override
  String get timerStudyDesc => 'Enfócate en el aprendizaje';

  @override
  String get timerCountdown => 'Cuenta regresiva';

  @override
  String get timerCountdownDesc => 'Temporizador personalizable';

  @override
  String get timerStopwatch => 'Cronómetro';

  @override
  String get timerStopwatchDesc => 'Medición de tiempo';

  @override
  String get timerDone => '¡Listo!';

  @override
  String get timerFinished => '¡Terminado!';

  @override
  String get timerFinishedTitle => '¡Temporizador terminado!';

  @override
  String timerFinishedBody(Object timerName) {
    return '$timerName terminado';
  }

  @override
  String get sessionSavedTitle => 'Sesión guardada';

  @override
  String get sessionSavedBody => 'Sesión del temporizador guardada en estadísticas';

  @override
  String get statisticsSelectMonth => 'Seleccionar mes';

  @override
  String get cancel => 'Cancelar';

  @override
  String get homeTitle => 'Super Chicken Timer';

  @override
  String get homeSubtitle => 'Elige tu temporizador';

  @override
  String todoProgress(Object done, Object total) {
    return '$done de $total completadas';
  }

  @override
  String get todoEmpty => 'Sin tareas';

  @override
  String get todoEmptyAdd => 'Añade tu primera tarea';

  @override
  String get todoNew => 'Nueva tarea';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get notificationChannelName => 'Notificaciones del temporizador';

  @override
  String get notificationChannelDescription => 'Notificaciones de finalización del temporizador';

  @override
  String get timerNameForestRoad => 'Camino del bosque';

  @override
  String get timerNameChickenFarm => 'Granja de pollos';

  @override
  String get timerNameChickenMountain => 'Montaña de pollos';

  @override
  String get languageRussian => 'Ruso';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageFrench => 'Francés';

  @override
  String todoTimeMinutesAgo(Object minutes) {
    return 'hace $minutes min';
  }

  @override
  String todoTimeHoursAgo(Object hours) {
    return 'hace $hours h';
  }

  @override
  String get todoTimeYesterday => 'Ayer';

  @override
  String todoTimeDaysAgo(Object days) {
    return 'hace $days días';
  }

  @override
  String get monthJan => 'Ene';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Abr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Ago';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dic';

  @override
  String get statTotalTime => 'Tiempo total';

  @override
  String get statSessions => 'Sesiones';

  @override
  String get statCompleted => 'Completado';
}
