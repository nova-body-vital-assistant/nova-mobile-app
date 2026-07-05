import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF006D36);
  static const Color primaryContainer = Color(0xFF00BF63);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF004620);

  static const Color surface = Color(0xFFF3FCF0);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEDF6EB);
  static const Color surfaceContainerHigh = Color(0xFFE2EBDF);
  static const Color onSurface = Color(0xFF161D17);
  static const Color onSurfaceVariant = Color(0xFF3C4A3E);
  static const Color outline = Color(0xFF6C7B6D);
  static const Color outlineVariant = Color(0xFFBBCBBB);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF5E5E5E);
  static const Color secondaryContainer = Color(0xFFE2E2E2);

  static const Color inverseSurface = Color(0xFF2A322B);
  static const Color inverseOnSurface = Color(0xFFEBF3E8);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        onPrimary: AppColors.onPrimary,
        onPrimaryContainer: AppColors.onPrimaryContainer,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        error: AppColors.error,
        onError: AppColors.onError,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryContainer,
        inverseSurface: AppColors.inverseSurface,
      ),
      scaffoldBackgroundColor: AppColors.surface,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 56 / 48,
          letterSpacing: -0.96,
        ),
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 36 / 28,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 32 / 24,
        ),
        bodyLarge: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          height: 28 / 18,
        ),
        bodyMedium: GoogleFonts.lexend(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
        ),
        labelMedium: GoogleFonts.lexend(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
          letterSpacing: 0.14,
        ),
        labelSmall: GoogleFonts.lexend(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 16 / 12,
        ),
      ),
    );
  }
}
