import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/statistics_service.dart';
import '../models/timer_model.dart';
import '../l10n/app_localizations.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime _selectedMonth = DateTime.now();

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
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: theme.textTheme.bodyLarge?.color ?? Colors.black87,
                      size: 24,
                    ),
                  ),
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
                      Icons.analytics,
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
                          loc.statisticsTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                theme.textTheme.bodyLarge?.color ??
                                Colors.black87,
                          ),
                        ),
                        Text(
                          loc.statisticsSubtitle,
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
                  const SizedBox(width: 48), // Для баланса
                ],
              ),
            ),

            // Выбор месяца
            _buildMonthSelector(theme),

            // Общая статистика
            _buildOverallStats(theme),

            // Список статистики по таймерам
            Expanded(
              child: Consumer<StatisticsService>(
                builder: (context, statsService, child) {
                  final statistics = statsService.getStatisticsForMonth(
                    _selectedMonth,
                  );

                  if (statistics.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.analytics_outlined,
                            size: 80,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            loc.statisticsEmpty,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.statisticsEmptyDesc,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: statistics.length,
                    itemBuilder: (context, index) {
                      return _buildTimerStatCard(
                        statistics[index],
                        theme,
                        statsService,
                      );
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

  Widget _buildMonthSelector(ThemeData theme) {
    final loc = AppLocalizations.of(context)!;
    return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Consumer<StatisticsService>(
                  builder: (context, statsService, child) {
                    return Text(
                      _getMonthName(_selectedMonth.month, loc),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () => _showMonthPicker(theme),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.3, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildOverallStats(ThemeData theme) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Consumer<StatisticsService>(
        builder: (context, statsService, child) {
          final totalTime = statsService.getTotalTimeForMonth(_selectedMonth);
          final totalSessions = statsService.getTotalSessionsForMonth(
            _selectedMonth,
          );
          final completedSessions = statsService.getCompletedSessionsForMonth(
            _selectedMonth,
          );

          return Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  loc.statTotalTime,
                  statsService.formatDuration(totalTime),
                  Icons.timer,
                  theme.colorScheme.primary,
                  theme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  loc.statSessions,
                  '$totalSessions',
                  Icons.play_circle,
                  theme.colorScheme.secondary,
                  theme,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  loc.statCompleted,
                  '$completedSessions',
                  Icons.check_circle,
                  Colors.green,
                  theme,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeData theme,
  ) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 8),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.textTheme.bodyMedium?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.3, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildTimerStatCard(
    TimerStatistics stats,
    ThemeData theme,
    StatisticsService statsService,
  ) {
    final loc = AppLocalizations.of(context)!;
    final completionRate = stats.sessionsCount > 0
        ? (stats.completedSessions / stats.sessionsCount * 100).round()
        : 0;

    return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getTimerColor(stats.timerType).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _getTimerIcon(stats.timerType),
                        color: _getTimerColor(stats.timerType),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stats.timerName,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          Text(
                            statsService.formatDuration(stats.totalTime),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: completionRate >= 80
                            ? Colors.green.withOpacity(0.1)
                            : completionRate >= 50
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$completionRate%',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: completionRate >= 80
                              ? Colors.green
                              : completionRate >= 50
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatItem(
                      loc.statSessions,
                      '${stats.sessionsCount}',
                      Icons.play_circle_outline,
                      theme,
                    ),
                    const SizedBox(width: 16),
                    _buildStatItem(
                      loc.statCompleted,
                      '${stats.completedSessions}',
                      Icons.check_circle_outline,
                      theme,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    ThemeData theme,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
        ),
        const SizedBox(width: 4),
        Text(
          '$value $label',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  void _showMonthPicker(ThemeData theme) {
    final loc = AppLocalizations.of(context)!;
    final currentYear = DateTime.now().year;
    final currentMonth = DateTime.now().month;
    DateTime tempSelectedMonth = _selectedMonth;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            loc.statisticsSelectMonth,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                // Выбор года
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setDialogState(() {
                            tempSelectedMonth = DateTime(
                              tempSelectedMonth.year - 1,
                              tempSelectedMonth.month,
                            );
                          });
                        },
                        icon: Icon(
                          Icons.chevron_left,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        tempSelectedMonth.year.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      IconButton(
                        onPressed: tempSelectedMonth.year < currentYear
                            ? () {
                                setDialogState(() {
                                  tempSelectedMonth = DateTime(
                                    tempSelectedMonth.year + 1,
                                    tempSelectedMonth.month,
                                  );
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.chevron_right,
                          color: tempSelectedMonth.year < currentYear
                              ? theme.colorScheme.primary
                              : theme.colorScheme.primary.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Сетка месяцев
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final month = index + 1;
                      final isSelected = tempSelectedMonth.month == month;
                      final isCurrentMonth =
                          currentYear == tempSelectedMonth.year &&
                          currentMonth == month;
                      final isPastMonth =
                          tempSelectedMonth.year < currentYear ||
                          (tempSelectedMonth.year == currentYear &&
                              month <= currentMonth);

                      return InkWell(
                        onTap: isPastMonth
                            ? () {
                                setState(() {
                                  _selectedMonth = DateTime(
                                    tempSelectedMonth.year,
                                    month,
                                  );
                                });
                                Navigator.pop(context);
                              }
                            : null,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : isPastMonth
                                ? theme.cardColor
                                : theme.cardColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                            border: isCurrentMonth
                                ? Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              _getMonthName(month, loc),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : isPastMonth
                                    ? theme.textTheme.bodyLarge?.color
                                    : theme.textTheme.bodyLarge?.color
                                          ?.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(loc.cancel),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month, AppLocalizations loc) {
    switch (month) {
      case 1:
        return loc.monthJan;
      case 2:
        return loc.monthFeb;
      case 3:
        return loc.monthMar;
      case 4:
        return loc.monthApr;
      case 5:
        return loc.monthMay;
      case 6:
        return loc.monthJun;
      case 7:
        return loc.monthJul;
      case 8:
        return loc.monthAug;
      case 9:
        return loc.monthSep;
      case 10:
        return loc.monthOct;
      case 11:
        return loc.monthNov;
      case 12:
        return loc.monthDec;
      default:
        return '';
    }
  }

  Color _getTimerColor(TimerType type) {
    switch (type) {
      case TimerType.pomodoro:
        return const Color(0xFFE74C3C);
      case TimerType.chicken:
        return const Color(0xFFFFD700);
      case TimerType.meditation:
        return const Color(0xFF9B59B6);
      case TimerType.workout:
        return const Color(0xFF2ECC71);
      case TimerType.study:
        return const Color(0xFF3498DB);
      case TimerType.countdown:
        return const Color(0xFFF39C12);
      case TimerType.stopwatch:
        return const Color(0xFF1ABC9C);
    }
  }

  IconData _getTimerIcon(TimerType type) {
    switch (type) {
      case TimerType.pomodoro:
        return Icons.timer;
      case TimerType.chicken:
        return Icons.pets;
      case TimerType.meditation:
        return Icons.self_improvement;
      case TimerType.workout:
        return Icons.fitness_center;
      case TimerType.study:
        return Icons.school;
      case TimerType.countdown:
        return Icons.hourglass_empty;
      case TimerType.stopwatch:
        return Icons.timer_outlined;
    }
  }
}
