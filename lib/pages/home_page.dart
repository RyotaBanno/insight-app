import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/post_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: InsightColors.background,

      // 上部ヘッダー（「ホーム / チームの成長記録」＋ 右上の丸アイコン）
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        shadowColor: Colors.black12,
        toolbarHeight: 72,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ホーム',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: InsightColors.textMain,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'チームの成長記録',
              style: theme.textTheme.bodySmall?.copyWith(
                color: InsightColors.textSub,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          // 右上にある黄緑の丸 + "I"
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: InsightColors.primary,
              child: const Text(
                'I',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 上部の学年フィルタ（全体 / 3年 / 2年 / 1年）
              const _GradeFilterBar(),
              const SizedBox(height: 16),

              // タイムライン（1日の記録カード）
              const PostCard(
                name: '田中太郎',
                grade: '3年',
                position: 'ピッチャー',
                date: '2025年1月24日',
                morningTitle: '朝練（6:00-8:00）',
                morningStrength: '8',
                morningContent: 'キャッチボール、投球練習、体幹トレーニング',
                morningComment: 'コントロールが安定してきた。ストレートの威力も上がっている感じがする。',
                afternoonTitle: '午後練（15:00-18:00）',
                afternoonStrength: '9',
                afternoonContent: 'ノック、バッティング練習、実戦形式',
              ),

              // ここに PostCard(...) をどんどん並べることで
              // インスタ風の「縦タイムライン」になる
              // const PostCard(...),
              // const PostCard(...),
            ],
          ),
        ),
      ),
    );
  }
}

/// 「全体 / 3年 / 2年 / 1年」ボタン群
/// 今は静的・見た目だけ。将来的にはStatefulにして選択学年で絞り込みする予定。
class _GradeFilterBar extends StatelessWidget {
  const _GradeFilterBar();

  @override
  Widget build(BuildContext context) {
    // 全体を白い箱にして、その中に4つのチップ
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: InsightColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _GradeChip(label: '全体', selected: true),
          _GradeChip(label: '3年'),
          _GradeChip(label: '2年'),
          _GradeChip(label: '1年'),
        ],
      ),
    );
  }
}

class _GradeChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _GradeChip({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: selected ? InsightColors.textMain : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected ? InsightColors.textMain : InsightColors.border,
          width: 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: selected ? Colors.white : InsightColors.textMain,
        ),
      ),
    );
  }
}
