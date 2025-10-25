import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'home_page.dart';
import 'post_page.dart';
import 'analysis_page.dart';
import 'settings_page.dart';

class HomeShell extends StatefulWidget {
  static const routeName = '/main'; // ログイン後ここに飛ばす

  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  // タブごとの中身
  final _pages = const [
    HomePage(), // ホーム（タイムライン）
    PostPage(), // 投稿
    AnalysisPage(), // 分析
    SettingsPage(), // 設定
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // いま選ばれてるタブの中身
      body: _pages[_currentIndex],

      // iPhoneっぽいボトムタブ
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: InsightColors.primary,
        unselectedItemColor: Colors.grey[500],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ホーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '投稿',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: '分析',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '設定',
          ),
        ],
      ),
    );
  }
}
