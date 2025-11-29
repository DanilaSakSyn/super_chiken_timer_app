import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:superchickentimerflutter/screens/super_chicken_timer_app.dart';
import 'home_screen.dart';
import 'todo_screen.dart';
import 'settings_screen.dart';
import '../services/notification_service.dart';
import '../services/theme_service.dart';
import '../services/locale_service.dart';
import '../services/todo_service.dart';
import '../services/statistics_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/app_localizations.dart';

class SuperChickenTimerApp extends StatelessWidget {
  const SuperChickenTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => LocaleService()),
        ChangeNotifierProvider(create: (_) => TodoService()),
        ChangeNotifierProvider(create: (_) => StatisticsService()),
      ],
      child: Consumer2<ThemeService, LocaleService>(
        builder: (context, themeService, localeService, child) {
          return MaterialApp(
            title: 'Super Chicken Timer',
            debugShowCheckedModeBanner: false,
            theme: themeService.getTheme(),
            locale: localeService.currentLocale,
            supportedLocales: localeService.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              // Если выбран пользователем язык, используем его
              if (localeService.currentLocale != null) {
                return localeService.currentLocale;
              }
              // Иначе используем системный язык
              if (locale == null) return supportedLocales.first;
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [HomeScreen(), TodoScreen(), SettingsScreen()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color:
              theme.bottomNavigationBarTheme.backgroundColor ?? theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _tabController.animateTo(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.textTheme.bodyMedium?.color?.withOpacity(
            0.6,
          ),
          selectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: loc.tabTimers,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.checklist_rounded),
              label: loc.tabTasks,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_rounded),
              label: loc.tabSettings,
            ),
          ],
        ),
      ),
    );
  }
}
