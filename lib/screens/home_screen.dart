import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/timer_model.dart';
import '../widgets/timer_card.dart';
import 'timer_screen.dart';
import 'chicken_timer_screen.dart';
import 'statistics_screen.dart';
import '../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TimerModel> get _timers {
    final loc = AppLocalizations.of(context)!;
    return [
      TimerModel(
        id: '7',
        name: loc.timerNameForestRoad,
        description: loc.chickenDescRoad,
        duration: const Duration(minutes: 25),
        type: TimerType.chicken,
        style: TimerStyle.classic,
        icon: '🛣️',
        primaryColor: const Color(0xFFFFD700),
        secondaryColor: const Color(0xFFFFA500),
        background: 'road_chicken_timer_back.webp',
      ),
      TimerModel(
        id: '8',
        name: loc.timerNameChickenFarm,
        description: loc.chickenDescFarm,
        duration: const Duration(minutes: 25),
        type: TimerType.chicken,
        style: TimerStyle.classic,
        icon: '🚜',
        primaryColor: const Color(0xFFFFD700),
        secondaryColor: const Color(0xFFFFA500),
        background: 'chicken_timer_back.webp',
      ),
      TimerModel(
        id: '9',
        name: loc.timerNameChickenMountain,
        description: loc.chickenDescMountain,
        duration: const Duration(minutes: 25),
        type: TimerType.chicken,
        style: TimerStyle.classic,
        icon: '⛰️',
        primaryColor: const Color(0xFFFFD700),
        secondaryColor: const Color(0xFFFFA500),
        background: 'chicken_timer_back2.webp',
      ),
      TimerModel(
        id: '2',
        name: loc.timerChicken,
        description: loc.chickenDescClassic,
        duration: const Duration(minutes: 25),
        type: TimerType.chicken,
        style: TimerStyle.classic,
        icon: '🐔',
        primaryColor: const Color(0xFFFFD700),
        secondaryColor: const Color(0xFFFFA500),
        background: 'farm_chicken_timer_back.webp',
      ),
      TimerModel(
        id: '1',
        name: loc.timerPomodoro,
        description: loc.timerPomodoroDesc,
        duration: const Duration(minutes: 25),
        type: TimerType.pomodoro,
        style: TimerStyle.classic,
        icon: '🍅',
        primaryColor: const Color(0xFFE74C3C),
        secondaryColor: const Color(0xFFC0392B),
      ),
      TimerModel(
        id: '2',
        name: loc.timerMeditation,
        description: loc.timerMeditationDesc,
        duration: const Duration(minutes: 10),
        type: TimerType.meditation,
        style: TimerStyle.gradient,
        icon: '🧘',
        primaryColor: const Color(0xFF9B59B6),
        secondaryColor: const Color(0xFF8E44AD),
      ),
      TimerModel(
        id: '3',
        name: loc.timerWorkout,
        description: loc.timerWorkoutDesc,
        duration: const Duration(minutes: 45),
        type: TimerType.workout,
        style: TimerStyle.neon,
        icon: '💪',
        primaryColor: const Color(0xFF2ECC71),
        secondaryColor: const Color(0xFF27AE60),
      ),
      TimerModel(
        id: '4',
        name: loc.timerStudy,
        description: loc.timerStudyDesc,
        duration: const Duration(minutes: 30),
        type: TimerType.study,
        style: TimerStyle.modern,
        icon: '📚',
        primaryColor: const Color(0xFF3498DB),
        secondaryColor: const Color(0xFF2980B9),
      ),
      TimerModel(
        id: '5',
        name: loc.timerCountdown,
        description: loc.timerCountdownDesc,
        duration: const Duration(minutes: 15),
        type: TimerType.countdown,
        style: TimerStyle.minimal,
        icon: '⏰',
        primaryColor: const Color(0xFFF39C12),
        secondaryColor: const Color(0xFFE67E22),
      ),
      TimerModel(
        id: '6',
        name: loc.timerStopwatch,
        description: loc.timerStopwatchDesc,
        duration: const Duration(seconds: 0),
        type: TimerType.stopwatch,
        style: TimerStyle.retro,
        icon: '⏱️',
        primaryColor: const Color(0xFF1ABC9C),
        secondaryColor: const Color(0xFF16A085),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8E53), Color(0xFFFF6B6B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.timer,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.homeTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                theme.textTheme.bodyLarge?.color ??
                                Colors.black87,
                          ),
                        ),
                        Text(
                          loc.homeSubtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color:
                                theme.textTheme.bodyMedium?.color ??
                                Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Кнопка статистики
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF8E53).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StatisticsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.analytics,
                        color: Color(0xFFFF8E53),
                        size: 24,
                      ),
                      tooltip: loc.tabStatistics,
                    ),
                  ),
                ],
              ),
            ),

            // Список таймеров
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _timers.length,
                itemBuilder: (context, index) {
                  return TimerCard(
                    timer: _timers[index],
                    onTap: () {
                      if (_timers[index].type == TimerType.chicken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChickenTimerScreen(timer: _timers[index]),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TimerScreen(timer: _timers[index]),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
