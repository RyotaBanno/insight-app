import 'package:flutter/material.dart';

/// INSIGHT アプリ全体で使用するブランドカラー定義。
class InsightColors {
  InsightColors._();

  /// スクリーンの基調となる背景色。
  static const Color background = Color(0xFFF7F9FB);

  /// タイムラインカードなどのサーフェスカラー。
  static const Color surface = Colors.white;

  /// サーフェスを浮かせるときの淡い背景。
  static const Color surfaceVariant = Color(0xFFF0F4F7);

  /// ブランドのメインカラー（アクセントグリーン）。
  static const Color primary = Color(0xFF74EE46);

  /// サブアクセント（淡いイエローグリーン）。
  static const Color secondary = Color(0xFFC7FF34);

  /// エレメントの境界線に使う薄いグレー。
  static const Color border = Color(0xFFE1E7EF);

  /// メインテキストカラー。
  static const Color textPrimary = Color(0xFF1B1F24);

  /// セカンダリテキストカラー。
  static const Color textSecondary = Color(0xFF5B6470);

  /// 補足ラベルなどに使うミュートカラー。
  static const Color textMuted = Color(0xFFA6AFBD);

  /// 練習セクションの背景カラー。
  static const Color practiceBackground = Color(0xFFE6F4FF);

  /// 強度バッジのテキストに合わせるディープカラー。
  static const Color intensity = Color(0xFFE53935);

  /// グレードフィルタの非選択時背景。
  static const Color chipBackground = Color(0xFFEFF3F8);
}
