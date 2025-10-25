import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme.dart';
import 'core/repository.dart';

import 'pages/login_page.dart';
import 'pages/home_shell.dart'; // ← ボトムタブ全体
import 'pages/home_page.dart'; // ホーム（タイムライン）
import 'pages/post_page.dart'; // 投稿
import 'pages/analysis_page.dart'; // 分析
import 'pages/settings_page.dart'; // 設定

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 疑似的なバックエンド的役割をまとめたリポジトリ
  final repo = InsightRepository();

  runApp(
    AppScope(
      repo: repo,
      child: const InsightApp(),
    ),
  );
}

/// アプリ全体に `InsightRepository` を共有するための InheritedWidget。
/// → 山田さんのAPIとつなげるときは、この repo の中身を
///   実サーバーアクセスに差し替える・拡張するだけで済む想定。
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.repo,
    required super.child,
  });

  final InsightRepository repo;

  static InsightRepository of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!.repo;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) => false;
}

class InsightApp extends StatelessWidget {
  const InsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'INSIGHT',
      debugShowCheckedModeBanner: false,
      theme: buildInsightTheme(),

      // ▼ ここで iPhone 幅っぽく中央にレイアウトを寄せる（Webプレビュー用）
      //    実機(iOS/Android)では画面幅いっぱいになるので問題ない。
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 430, // iPhone 14 Pro Max くらいの幅に寄せる
            ),
            child: child!,
          ),
        );
      },

      // ローカライズ（日本語/英語、日付フォーマットなど）
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'),
        Locale('en'),
      ],

      // 起動時はまずログイン画面
      initialRoute: LoginPage.routeName,

      // 画面ルーティング定義
      routes: {
        // ログイン
        LoginPage.routeName: (_) => const LoginPage(),

        // ログイン後のボトムタブ全体（ホーム/投稿/分析/設定）
        HomeShell.routeName: (_) => const HomeShell(),

        // タブ画面（Shell内でも使うので明示的に保持）
        HomePage.routeName: (_) => const HomePage(),
        PostPage.routeName: (_) => const PostPage(),
        AnalysisPage.routeName: (_) => const AnalysisPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
      },
    );
  }
}
