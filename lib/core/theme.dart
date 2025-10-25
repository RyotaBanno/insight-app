import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData buildInsightTheme() {
  final base = ThemeData.light(useMaterial3: true);

  return base.copyWith(
    useMaterial3: true,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: InsightColors.background,
    colorScheme: base.colorScheme.copyWith(
      primary: InsightColors.primary,
      secondary: InsightColors.secondary,
      surface: InsightColors.surface,
      background: InsightColors.background,
      outline: InsightColors.border,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: InsightColors.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 64,
      titleSpacing: 0,
      centerTitle: false,
      foregroundColor: InsightColors.textPrimary,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: InsightColors.textPrimary,
        letterSpacing: -0.2,
      ),
    ),
    textTheme: base.textTheme.copyWith(
      headlineSmall: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: InsightColors.textPrimary,
        letterSpacing: -0.2,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: InsightColors.textPrimary,
        height: 1.32,
      ),
      bodyLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: InsightColors.textPrimary,
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: InsightColors.textSecondary,
        height: 1.5,
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: InsightColors.textMuted,
        height: 1.4,
      ),
      labelSmall: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: InsightColors.textSecondary,
        letterSpacing: 0.2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: InsightColors.primary,
        foregroundColor: InsightColors.textPrimary,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: InsightColors.chipBackground,
      selectedColor: InsightColors.textPrimary,
      secondarySelectedColor: InsightColors.primary,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: InsightColors.textSecondary,
      ),
      secondaryLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    dividerTheme: const DividerThemeData(
      color: InsightColors.border,
      thickness: 1,
      space: 32,
    ),
  );
}
