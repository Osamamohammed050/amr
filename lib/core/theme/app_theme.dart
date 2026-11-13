import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primaryGold,
    splashColor: AppColors.primaryGold.withValues(alpha: 0.12),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        color: AppColors.white,
        fontSize: 64,
        fontWeight: FontWeight.bold,
        height: 1.05,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        color: AppColors.white,
        fontSize: 42,
        fontWeight: FontWeight.w700,
        height: 1.1,
      ),
      headlineMedium: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppColors.gray,
        fontSize: 16,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.gray,
        fontSize: 14,
        height: 1.5,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      surface: AppColors.surface,
      primary: AppColors.primaryGold,
      onPrimary: AppColors.white,
      onSurface: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      backgroundColor: AppColors.transparent,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: TextStyle(color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
