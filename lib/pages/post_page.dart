import 'package:flutter/material.dart';
import '../main.dart';
import '../models/post.dart';

class PostPage extends StatefulWidget {
  static const routeName = '/post';
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // フォームコントローラ
  final _trainingCategoryCtrl = TextEditingController();
  final _trainingDetailCtrl = TextEditingController();
  final _insightsCtrl = TextEditingController();
  double _intensity = 3;

  final _mealsNoteCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _sleepCtrl = TextEditingController();
  final _energyCtrl = TextEditingController();
  final _muscleCtrl = TextEditingController();
  final _waterCtrl = TextEditingController();
  final _fatCtrl = TextEditingController();
  final _bmiCtrl = TextEditingController();

  bool _submitting = false;
  String? _errorText;

  Future<void> _submit() async {
    setState(() {
      _submitting = true;
      _errorText = null;
    });

    final repo = AppScope.of(context);

    final post = Post(
      id: null,
      userId: repo.currentUser?.id ?? 'me',
      date: DateTime.now(),
      trainingCategory: _trainingCategoryCtrl.text.trim(),
      trainingDetail: _trainingDetailCtrl.text.trim(),
      insights: _insightsCtrl.text.trim(),
      intensity: _intensity.toInt(),
      mealsNote: _mealsNoteCtrl.text.trim(),
      weight: double.tryParse(_weightCtrl.text),
      sleepHours: double.tryParse(_sleepCtrl.text),
      energyLevel: int.tryParse(_energyCtrl.text),
      muscle: double.tryParse(_muscleCtrl.text),
      water: double.tryParse(_waterCtrl.text),
      bodyFat: double.tryParse(_fatCtrl.text),
      bmi: double.tryParse(_bmiCtrl.text),
      comments: const [],
    );

    try {
      await repo.createPost(post);
      if (!mounted) return;
      Navigator.of(context).pop(); // 戻る
    } catch (e) {
      setState(() {
        _errorText = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  Widget _sectionHeader(String emoji, String title, [String? sub]) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (sub != null) ...[
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('日次記録を投稿'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ① 練習・気づき
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader('🏃', '① 練習・気づき', '今日やったこと・感じたこと'),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _trainingCategoryCtrl,
                      decoration: const InputDecoration(
                        labelText: 'メニュー分類',
                        hintText: '例: バッティング / 体幹 / 走塁 など',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _trainingDetailCtrl,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '具体的な内容',
                        hintText: '例: ティー打撃 100本 / 細かい修正ポイント など',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _insightsCtrl,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '気づき・課題',
                        hintText: '良かった点 / 直したい点 / 次に意識すること',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '強度（きつさ）: ${_intensity.toInt()}/5',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Slider(
                      value: _intensity,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: _intensity.toInt().toString(),
                      activeColor: theme.colorScheme.primary,
                      onChanged: (v) {
                        setState(() {
                          _intensity = v;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ② 食事・体調
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader('🍽', '② 食事・体調', 'コンディションのメモ'),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _mealsNoteCtrl,
                      minLines: 2,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '食事メモ',
                        hintText: '何を食べた？ 炭水化物・たんぱく質は？',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _weightCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: '体重(kg)',
                              hintText: '例: 72.4',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _sleepCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: '睡眠(h)',
                              hintText: '例: 6.5',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _energyCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: '元気(1-5)',
                              hintText: '4',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _muscleCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: '筋肉(%)',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _waterCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: '水分(%)',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _fatCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: '体脂肪(%)',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: _bmiCtrl,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: const InputDecoration(
                              labelText: 'BMI',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (_errorText != null) ...[
                const SizedBox(height: 16),
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
                onPressed: _submitting ? null : _submit,
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text('投稿する'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
