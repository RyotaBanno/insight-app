import 'package:flutter/material.dart';

/// アプリ全体のカラーパレット（仮デザイン用）
class InsightColors {
  // メインのアクセントカラー（成長イメージの明るいグリーン）
  static const Color primary = Color(0xFF2ECC71);

  // 画面全体の背景（薄いグレー）
  static const Color bg = Color(0xFFF7F8FA);

  // カードの背景
  static const Color cardBg = Colors.white;

  // テキスト色
  static const Color textMain = Color(0xFF1A1A1A);
  static const Color textSub = Color(0xFF667085);

  // 枠線などに使う非常に薄いグレー
  static const Color border = Color(0xFFE5E7EB);
}

ThemeData buildInsightTheme() {
  final base = ThemeData.light();

  return base.copyWith(
    // 画面全体の背景
    scaffoldBackgroundColor: InsightColors.bg,

    // カラースキーム
    colorScheme: base.colorScheme.copyWith(
      primary: InsightColors.primary,
      secondary: InsightColors.primary,
      surface: InsightColors.cardBg,
      background: InsightColors.bg,
      brightness: Brightness.light,
    ),

    // AppBarを「白いカード＋薄い影」っぽくする
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.8,
      shadowColor: Colors.black12,
      surfaceTintColor: Colors.transparent,
      foregroundColor: InsightColors.textMain,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: InsightColors.textMain,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: InsightColors.textMain,
      ),
    ),

    // CTAボタン（ログイン、投稿する 等）
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: InsightColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size.fromHeight(48),
        elevation: 2,
        shadowColor: Colors.black26,
      ),
    ),

    // TextFieldスタイル（白いボックス+角丸+枠線）
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: InsightColors.border,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: InsightColors.border,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: InsightColors.primary,
          width: 2,
        ),
      ),
      labelStyle: const TextStyle(
        color: InsightColors.textSub,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: InsightColors.textSub,
        fontSize: 14,
      ),
    ),

    // テキストスタイル
    textTheme: base.textTheme.copyWith(
      bodyLarge: const TextStyle(
        color: InsightColors.textMain,
        fontSize: 16,
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        color: InsightColors.textMain,
        fontSize: 14,
        height: 1.5,
      ),
      bodySmall: const TextStyle(
        color: InsightColors.textSub,
        fontSize: 12,
        height: 1.4,
      ),
      titleMedium: const TextStyle(
        color: InsightColors.textMain,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      headlineSmall: const TextStyle(
        color: InsightColors.textMain,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
    ),

    // Fab（右下のアクションボタン等）
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: InsightColors.primary,
      foregroundColor: Colors.white,
    ),
  );
}
