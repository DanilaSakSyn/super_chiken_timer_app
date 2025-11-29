import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/timer_model.dart';

class TimerControls extends StatelessWidget {
  final bool isRunning;
  final bool isPaused;
  final bool isCompleted;
  final TimerStyle style;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onReset;

  const TimerControls({
    super.key,
    required this.isRunning,
    required this.isPaused,
    required this.isCompleted,
    required this.style,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case TimerStyle.classic:
        return _buildClassicControls(context);
      case TimerStyle.modern:
        return _buildModernControls(context);
      case TimerStyle.gradient:
        return _buildGradientControls(context);
      case TimerStyle.neon:
        return _buildNeonControls(context);
      case TimerStyle.minimal:
        return _buildMinimalControls(context);
      case TimerStyle.retro:
        return _buildRetroControls(context);
    }
  }

  Widget _buildClassicControls(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildClassicButton(
          context: context,
          icon: Icons.refresh,
          onPressed: onReset,
          color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600]!,
        ),
        _buildClassicButton(
          context: context,
          icon: isRunning && !isPaused ? Icons.pause : Icons.play_arrow,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: primaryColor,
          isLarge: true,
        ),
        _buildClassicButton(
          context: context,
          icon: Icons.stop,
          onPressed: isRunning ? onReset : null,
          color: Colors.red[600]!,
        ),
      ],
    );
  }

  Widget _buildClassicButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    final theme = Theme.of(context);
    return Container(
          width: isLarge ? 80 : 60,
          height: isLarge ? 80 : 60,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(isLarge ? 40 : 30),
            border: Border.all(color: color.withOpacity(0.3), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 40 : 30),
              child: Icon(icon, color: color, size: isLarge ? 32 : 24),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildModernControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildModernButton(
          context: context,
          icon: Icons.refresh_rounded,
          onPressed: onReset,
          color: Colors.white.withOpacity(0.8),
        ),
        _buildModernButton(
          context: context,
          icon: isRunning && !isPaused
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: Colors.white,
          isLarge: true,
        ),
        _buildModernButton(
          context: context,
          icon: Icons.stop_rounded,
          onPressed: isRunning ? onReset : null,
          color: Colors.white.withOpacity(0.8),
        ),
      ],
    );
  }

  Widget _buildModernButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    final theme = Theme.of(context);
    return Container(
          width: isLarge ? 90 : 70,
          height: isLarge ? 90 : 70,
          decoration: BoxDecoration(
            color: isLarge ? theme.cardColor : theme.cardColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(isLarge ? 45 : 35),
            boxShadow: isLarge
                ? [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 45 : 35),
              child: Icon(
                icon,
                color: isLarge ? primaryColor : color,
                size: isLarge ? 36 : 28,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildGradientControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGradientButton(
          context: context,
          icon: Icons.refresh,
          onPressed: onReset,
          color: Colors.white,
        ),
        _buildGradientButton(
          context: context,
          icon: isRunning && !isPaused ? Icons.pause : Icons.play_arrow,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: Colors.white,
          isLarge: true,
        ),
        _buildGradientButton(
          context: context,
          icon: Icons.stop,
          onPressed: isRunning ? onReset : null,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildGradientButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    return Container(
          width: isLarge ? 85 : 65,
          height: isLarge ? 85 : 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(isLarge ? 42.5 : 32.5),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 42.5 : 32.5),
              child: Icon(icon, color: color, size: isLarge ? 34 : 26),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildNeonControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNeonButton(
          context: context,
          icon: Icons.refresh,
          onPressed: onReset,
          color: primaryColor,
        ),
        _buildNeonButton(
          context: context,
          icon: isRunning && !isPaused ? Icons.pause : Icons.play_arrow,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: primaryColor,
          isLarge: true,
        ),
        _buildNeonButton(
          context: context,
          icon: Icons.stop,
          onPressed: isRunning ? onReset : null,
          color: primaryColor,
        ),
      ],
    );
  }

  Widget _buildNeonButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    return Container(
          width: isLarge ? 90 : 70,
          height: isLarge ? 90 : 70,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(isLarge ? 45 : 35),
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 45 : 35),
              child: Icon(icon, color: color, size: isLarge ? 36 : 28),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildMinimalControls(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMinimalButton(
          context: context,
          icon: Icons.refresh,
          onPressed: onReset,
          color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600]!,
        ),
        _buildMinimalButton(
          context: context,
          icon: isRunning && !isPaused ? Icons.pause : Icons.play_arrow,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: primaryColor,
          isLarge: true,
        ),
        _buildMinimalButton(
          context: context,
          icon: Icons.stop,
          onPressed: isRunning ? onReset : null,
          color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600]!,
        ),
      ],
    );
  }

  Widget _buildMinimalButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    return Container(
          width: isLarge ? 75 : 55,
          height: isLarge ? 75 : 55,
          decoration: BoxDecoration(
            color: isLarge ? primaryColor : primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(isLarge ? 37.5 : 27.5),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 37.5 : 27.5),
              child: Icon(
                icon,
                color: isLarge ? Colors.white : color,
                size: isLarge ? 32 : 24,
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildRetroControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRetroButton(
          context: context,
          icon: Icons.refresh,
          onPressed: onReset,
          color: primaryColor,
        ),
        _buildRetroButton(
          context: context,
          icon: isRunning && !isPaused ? Icons.pause : Icons.play_arrow,
          onPressed: isRunning && !isPaused
              ? onPause
              : (isPaused ? onResume : onStart),
          color: primaryColor,
          isLarge: true,
        ),
        _buildRetroButton(
          context: context,
          icon: Icons.stop,
          onPressed: isRunning ? onReset : null,
          color: primaryColor,
        ),
      ],
    );
  }

  Widget _buildRetroButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
    bool isLarge = false,
  }) {
    return Container(
          width: isLarge ? 80 : 60,
          height: isLarge ? 80 : 60,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(isLarge ? 40 : 30),
            border: Border.all(
              color: color,
              width: 3,
              style: BorderStyle.solid,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(isLarge ? 40 : 30),
              child: Icon(icon, color: color, size: isLarge ? 30 : 22),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }
}
