import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/locale_service.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final localeService = Provider.of<LocaleService>(context);
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      Icons.settings,
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
                          loc.settings,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                Colors.black87,
                          ),
                        ),
                        Text(
                          loc.settingsPersonalize,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color
                                    ?.withOpacity(0.7) ??
                                Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Список настроек
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildSettingsSection(
                    title: loc.settingsTheme,
                    icon: Icons.palette,
                    children: [
                      _buildThemeSelector(themeService, loc),
                      _buildSwitchTile(
                        title: loc.settingsDarkMode,
                        subtitle: loc.settingsDarkModeHint,
                        value: themeService.currentTheme == AppTheme.dark,
                        onChanged: (value) {
                          themeService.setTheme(
                            value ? AppTheme.dark : AppTheme.light,
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildSettingsSection(
                    title: loc.settingsLanguage,
                    icon: Icons.language,
                    children: [_buildLanguageDropdown(localeService, loc)],
                  ),
                  const SizedBox(height: 20),
                  _buildSettingsSection(
                    title: loc.settingsAbout,
                    icon: Icons.info,
                    children: [
                      _buildInfoTile(
                        title: loc.settingsVersion,
                        subtitle: '1.0.2',
                        icon: Icons.app_settings_alt,
                      ),
                      _buildInfoTile(
                        title: loc.settingsDeveloper,
                        subtitle: loc.settingsTeam,
                        icon: Icons.person,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSelector(ThemeService themeService, AppLocalizations loc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          loc.settingsTheme,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
          ),
        ),
        subtitle: Text(
          loc.settingsThemeHint,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color:
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
                Colors.grey[600],
          ),
        ),
        trailing: DropdownButton<AppTheme>(
          value: themeService.currentTheme,
          onChanged: (theme) {
            if (theme != null) themeService.setTheme(theme);
          },
          underline: Container(),
          items: AppTheme.values.map((theme) {
            return DropdownMenuItem<AppTheme>(
              value: theme,
              child: Row(
                children: [
                  Icon(themeService.getThemeIcon(theme), size: 18),
                  const SizedBox(width: 8),
                  Text(themeService.getThemeName(theme, context)),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(
    LocaleService localeService,
    AppLocalizations loc,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          loc.settingsLanguage,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color:
                Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87,
          ),
        ),
        subtitle: Text(
          loc.settingsLanguageHint,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color:
                Theme.of(
                  context,
                ).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
                Colors.grey[600],
          ),
        ),
        trailing: DropdownButton<Locale>(
          value: localeService.currentLocale,
          onChanged: (locale) {
            if (locale != null) localeService.setLocale(locale);
          },
          underline: Container(),
          items: localeService.supportedLocales.map((locale) {
            return DropdownMenuItem<Locale>(
              value: locale,
              child: Text(localeService.getLocaleName(locale, loc)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    return Container(
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            theme.textTheme.bodyLarge?.color ?? Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              ...children,
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3, duration: 600.ms, curve: Curves.easeOutCubic);
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: enabled
                ? theme.textTheme.bodyLarge?.color ?? Colors.black87
                : theme.textTheme.bodyLarge?.color?.withOpacity(0.4) ??
                      Colors.grey[400],
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: enabled
                ? theme.textTheme.bodyMedium?.color ?? Colors.grey[600]
                : theme.textTheme.bodyMedium?.color?.withOpacity(0.4) ??
                      Colors.grey[400],
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: enabled ? onChanged : null,
          activeColor: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600],
          size: 20,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.bodyLarge?.color ?? Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.textTheme.bodyMedium?.color ?? Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
