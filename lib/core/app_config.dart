import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AppConfig {
  static const String appsFlyerDevKey = '88LtKkieqwN6Ad7tSKvqPX';
  static const String appsFlyerAppId = '6748400024'; // Для iOS'
  static const String bundleId = 'com.lditdifgjulx.fypbrrzgsvnf'; // Для iOS'
  static const String locale = 'en'; // Для iOS'
  static const String os = 'iOS'; // Для iOS'
  static const String endpoint = 'https://superchickentimer.com'; // Для iOS'
  static const String firebaseProjectId =
      'super-chicken-timer-b9e58'; // Для iOS'

  //UI Settings
  // Splash Screen
  static const Decoration splashDecoration = const BoxDecoration(
    gradient: AppConfig.splashGradient,
  );

  static const Gradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4F5D81), Color(0xFF050E4D)],
  );
  static const String logoPath = 'assets/images/Logo.webp';

  static const Color loadingTextColor = Color(0xFFFFFFFF);
  static const Color spinerColor = Color(0xFCFFFFFF);
  // Push Request Screen Settings

  static const Decoration pushRequestDecoration = const BoxDecoration(
    gradient: AppConfig.pushRequestGradient,
  );

  static const Gradient pushRequestGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F5D81), Color(0xFF050E4D)],
  );
  static const Gradient pushRequestFadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color.fromARGB(135, 0, 0, 0)],
  );
  static const Color titleTextColor = Color(0xFFFFFFFF);
  static const Color subtitleTextColor = Color(0x80FDFDFD);

  static const Color yesButtonColor = Color(0xFFFFB301);
  static const Color yesButtonShadowColor = Color(0xFF8B3619);
  static const Color yesButtonTextColor = Color(0xFFFFFFFF);
  static const Color skipTextColor = Color(0x7DF9F9F9);

  // Путь к логотипу, если не находит добавить в pubspec.yaml
  static const String pushRequestLogoPath = 'assets/images/Logo.webp';

  // экран ошибки подключения интернета
  // Error Screen
  static const Decoration errorScreenDecoration = const BoxDecoration(
    gradient: AppConfig.errorScreenGradient,
  );

  static const Gradient errorScreenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4F5D81), Color(0xFF050E4D)],
  );
  static const Color errorScreenTextColor = Color(0xFFFFFFFF);
  static const Color errorScreenIconColor = Color(0xFCFFFFFF);
}
