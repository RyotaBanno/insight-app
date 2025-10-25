import 'package:flutter/material.dart';
import '../main.dart';
// import 'home_page.dart'; // ←もう直接ホームに行かないので不要
import 'home_shell.dart'; // ←新しく作ったタブ付きメインレイアウトをインポート

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  bool _loading = false;
  String? _errorText;

  Future<void> _onLogin() async {
    setState(() {
      _loading = true;
      _errorText = null;
    });

    try {
      // AppScope は main.dart で用意した InheritedWidget
      // → 疑似ログイン処理にアクセスしてる
      final user = await AppScope.of(context).login(
        userId: _idCtrl.text.trim(),
        password: _pwCtrl.text.trim(),
      );

      if (!mounted) return;

      if (user == null) {
        // ログイン失敗時のエラーメッセージ
        setState(() {
          _errorText = 'ログインに失敗しました';
        });
      } else {
        // 🔁 ここを変更：
        // いままでは HomePage に行ってた
        // これからはタブバーを持った HomeShell に行く
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeShell.routeName, // ←ここがポイント
          (route) => false, // これでログイン画面を履歴から消す
        );
      }
    } catch (e) {
      setState(() {
        _errorText = 'エラーが発生しました';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ブランドヘッダー
              Text(
                'INSIGHT',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '日々の積み重ねを見える化し、成長につなげる',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 24),

              // ログインフォーム（カード風）
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: _idCtrl,
                        decoration: const InputDecoration(
                          labelText: 'ユーザーID',
                          hintText: '例: player_12',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _pwCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'パスワード',
                          hintText: '••••••••',
                        ),
                      ),
                      if (_errorText != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          _errorText!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loading ? null : _onLogin,
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text('ログイン'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Text(
                '※「coach」を含むIDでログインすると顧問アカウントとして扱われます',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
