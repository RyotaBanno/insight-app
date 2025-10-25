import 'package:flutter/material.dart';

/// アプリ全体で使うカラーパレット。
/// Figmaの見た目に近づけるための仮定色なので、あとで数値は調整OK。
class InsightColors {
  /// 画面全体の背景色（すこし明るいグレーっぽい）
  static const Color background = Color(0xFFF7F8FA);

  /// カード背景の白
  static const Color cardBg = Colors.white;

  /// カードなどの枠線・ボーダーに使う薄いグレー
  static const Color border = Color(0xFFE5E7EB);

  /// メインテキスト（ほぼ黒に近い濃いグレー）
  static const Color textMain = Color(0xFF1A1A1A);

  /// サブテキスト（説明文などのグレー）
  static const Color textSub = Color(0xFF667085);

  /// プロフィールアイコンなどで使っていた黄緑のアクセント
  /// ※Figmaの右上「I」が入った丸い背景のイメージ
  static const Color primary = Color(0xFFCEFF33);

  /// 「練習記録」セクションの薄い水色背景
  static const Color lightSectionBg = Color(0xFFEFF7FF);

  /// 強度バッジ（赤い pill の背景）
  static const Color intensityRed = Color(0xFFE53935);
}
