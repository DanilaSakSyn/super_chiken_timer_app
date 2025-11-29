// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Супер Куриный Таймер';

  @override
  String get tabTimers => 'Таймеры';

  @override
  String get tabTasks => 'Задачи';

  @override
  String get tabStatistics => 'Статистика';

  @override
  String get tabSettings => 'Настройки';

  @override
  String get settings => 'Настройки';

  @override
  String get settingsPersonalize => 'Персонализация приложения';

  @override
  String get settingsTheme => 'Тема приложения';

  @override
  String get settingsThemeHint => 'Системная, светлая или темная';

  @override
  String get settingsDarkMode => 'Темный режим';

  @override
  String get settingsDarkModeHint => 'Использовать темную тему';

  @override
  String get settingsNotifications => 'Уведомления';

  @override
  String get settingsEnableNotifications => 'Включить уведомления';

  @override
  String get settingsEnableNotificationsHint => 'Получать уведомления о завершении таймера';

  @override
  String get settingsSound => 'Звуковые уведомления';

  @override
  String get settingsSoundHint => 'Воспроизводить звук при завершении';

  @override
  String get settingsVibration => 'Вибрация';

  @override
  String get settingsVibrationHint => 'Вибрация при завершении таймера';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageHint => 'Выберите предпочитаемый язык';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsVersion => 'Версия';

  @override
  String get settingsDeveloper => 'Разработчик';

  @override
  String get settingsLicense => 'Лицензия';

  @override
  String get settingsTeam => 'FRANCISCUS WILHELMUS VAN DORT';

  @override
  String get settingsMIT => 'MIT Лицензия';

  @override
  String get statisticsTitle => 'Статистика';

  @override
  String get statisticsSubtitle => 'Отслеживайте использование таймеров';

  @override
  String get statisticsEmpty => 'Нет данных';

  @override
  String get statisticsEmptyDesc => 'Начните использовать таймеры, чтобы увидеть статистику здесь';

  @override
  String get todoTitle => 'Мои задачи';

  @override
  String todoCompleted(Object count, Object total) {
    return '$count из $total выполнено';
  }

  @override
  String get todoNoTasks => 'Нет задач';

  @override
  String get todoAddFirst => 'Добавьте первую задачу';

  @override
  String get todoAdd => 'Добавить';

  @override
  String get todoEdit => 'Редактировать задачу';

  @override
  String get todoCancel => 'Отмена';

  @override
  String get todoSave => 'Сохранить';

  @override
  String get todoNewTask => 'Новая задача';

  @override
  String get todoName => 'Название';

  @override
  String get todoDescription => 'Описание (необязательно)';

  @override
  String get todoTitleLabel => 'Название задачи';

  @override
  String get todoDescriptionLabel => 'Описание (необязательно)';

  @override
  String get todoTitleRequired => 'Название обязательно';

  @override
  String get todoDeleteTitle => 'Удалить задачу';

  @override
  String get todoDeleteMessage => 'Вы уверены, что хотите удалить эту задачу?';

  @override
  String get todoClearCompleted => 'Очистить выполненные';

  @override
  String get todoClearCompletedTitle => 'Очистить выполненные задачи';

  @override
  String todoClearCompletedMessage(Object count) {
    return 'Удалить $count выполненных задач?';
  }

  @override
  String get delete => 'Удалить';

  @override
  String get clear => 'Очистить';

  @override
  String get timerPomodoro => 'Помодоро';

  @override
  String get timerPomodoroDesc => '25 минут работы, 5 минут перерыва';

  @override
  String get timerChicken => 'Куриный Таймер';

  @override
  String get timerChickenDesc => 'Настраиваемые циклы работы и отдыха';

  @override
  String get chickenDescRoad => 'Таймер для продуктивной работы на лесной дороге. Почувствуй свежесть природы!';

  @override
  String get chickenDescFarm => 'Таймер для работы и отдыха на ферме. Вдохновляйся атмосферой деревни!';

  @override
  String get chickenDescMountain => 'Таймер для фокусировки среди гор и природы. Достигай новых высот!';

  @override
  String get chickenDescClassic => 'Классический куриный таймер для эффективной работы и отдыха.';

  @override
  String get chickenSettingsTitle => 'Настройки Куриного Таймера';

  @override
  String get chickenWorkTime => 'Время работы';

  @override
  String get chickenBreakTime => 'Время перерыва';

  @override
  String get chickenLongBreakTime => 'Время длинного перерыва';

  @override
  String get chickenSessionsBeforeLongBreak => 'Сессий до длинного перерыва';

  @override
  String get chickenStart => 'Старт';

  @override
  String get chickenPause => 'Пауза';

  @override
  String get chickenResume => 'Продолжить';

  @override
  String get chickenReset => 'Сброс';

  @override
  String get chickenWork => 'Работа';

  @override
  String get chickenBreak => 'Перерыв';

  @override
  String get chickenWorkComplete => 'Работа завершена!';

  @override
  String get chickenBreakComplete => 'Перерыв завершен!';

  @override
  String get chickenWorkCompleteBody => 'Время сделать перерыв!';

  @override
  String get chickenBreakCompleteBody => 'Время вернуться к работе!';

  @override
  String get timerMeditation => 'Медитация';

  @override
  String get timerMeditationDesc => 'Спокойствие и концентрация';

  @override
  String get timerWorkout => 'Тренировка';

  @override
  String get timerWorkoutDesc => 'Интенсивная тренировка';

  @override
  String get timerStudy => 'Учеба';

  @override
  String get timerStudyDesc => 'Сосредоточьтесь на обучении';

  @override
  String get timerCountdown => 'Обратный отсчет';

  @override
  String get timerCountdownDesc => 'Настраиваемый таймер';

  @override
  String get timerStopwatch => 'Секундомер';

  @override
  String get timerStopwatchDesc => 'Измерение времени';

  @override
  String get timerDone => 'Готово!';

  @override
  String get timerFinished => 'Завершено!';

  @override
  String get timerFinishedTitle => 'Таймер завершен!';

  @override
  String timerFinishedBody(Object timerName) {
    return '$timerName завершен';
  }

  @override
  String get sessionSavedTitle => 'Сессия сохранена';

  @override
  String get sessionSavedBody => 'Сессия таймера сохранена в статистику';

  @override
  String get statisticsSelectMonth => 'Выберите месяц';

  @override
  String get cancel => 'Отмена';

  @override
  String get homeTitle => 'Супер Куриный Таймер';

  @override
  String get homeSubtitle => 'Выберите таймер';

  @override
  String todoProgress(Object done, Object total) {
    return '$done из $total выполнено';
  }

  @override
  String get todoEmpty => 'Нет задач';

  @override
  String get todoEmptyAdd => 'Добавьте свою первую задачу';

  @override
  String get todoNew => 'Новая задача';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Темная';

  @override
  String get themeSystem => 'Системная';

  @override
  String get notificationChannelName => 'Уведомления таймера';

  @override
  String get notificationChannelDescription => 'Уведомления о завершении таймера';

  @override
  String get timerNameForestRoad => 'Лесная дорога';

  @override
  String get timerNameChickenFarm => 'Куриная ферма';

  @override
  String get timerNameChickenMountain => 'Куриная гора';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageFrench => 'Французский';

  @override
  String todoTimeMinutesAgo(Object minutes) {
    return '$minutes мин назад';
  }

  @override
  String todoTimeHoursAgo(Object hours) {
    return '$hours ч назад';
  }

  @override
  String get todoTimeYesterday => 'Вчера';

  @override
  String todoTimeDaysAgo(Object days) {
    return '$days дн назад';
  }

  @override
  String get monthJan => 'Янв';

  @override
  String get monthFeb => 'Фев';

  @override
  String get monthMar => 'Мар';

  @override
  String get monthApr => 'Апр';

  @override
  String get monthMay => 'Май';

  @override
  String get monthJun => 'Июн';

  @override
  String get monthJul => 'Июл';

  @override
  String get monthAug => 'Авг';

  @override
  String get monthSep => 'Сен';

  @override
  String get monthOct => 'Окт';

  @override
  String get monthNov => 'Ноя';

  @override
  String get monthDec => 'Дек';

  @override
  String get statTotalTime => 'Общее время';

  @override
  String get statSessions => 'Сессии';

  @override
  String get statCompleted => 'Завершено';
}
