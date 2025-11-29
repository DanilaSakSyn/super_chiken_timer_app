import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class LocaleService extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  Locale? _currentLocale;

  Locale? get currentLocale => _currentLocale;

  final List<Locale> supportedLocales = const [
    Locale('ru'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  LocaleService() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null) {
      _currentLocale = Locale(languageCode);
    }
    notifyListeners();
  }

  Future<void> setLocale(Locale locale) async {
    if (_currentLocale?.languageCode == locale.languageCode) return;

    _currentLocale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  String getLocaleName(Locale locale, AppLocalizations loc) {
    switch (locale.languageCode) {
      case 'ru':
        return loc.languageRussian;
      case 'en':
        return loc.languageEnglish;
      case 'es':
        return loc.languageSpanish;
      case 'fr':
        return loc.languageFrench;
      default:
        return locale.languageCode;
    }
  }
}
