import 'package:flutter/material.dart';
import '../core/colors.dart';

class PostCard extends StatelessWidget {
  final String name;
  final String grade;
  final String position;
  final String date;

  final String morningTitle;
  final String morningStrength;
  final String morningContent;
  final String morningComment;

  final String afternoonTitle;
  final String afternoonStrength;
  final String afternoonContent;

  const PostCard({
    super.key,
    required this.name,
    required this.grade,
    required this.position,
    required this.date,
    required this.morningTitle,
    required this.morningStrength,
    required this.morningContent,
    required this.morningComment,
    required this.afternoonTitle,
    required this.afternoonStrength,
    required this.afternoonContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 白い角丸カード＋薄いシャドウ＋淡いボーダー
      decoration: BoxDecoration(
        color: InsightColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: InsightColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ヘッダー部（アイコン + 名前/学年/ポジション/日付）
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: InsightColors.primary,
                child: Text(
                  _initials(name),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeaderMeta(
                  name: name,
                  grade: grade,
                  position: position,
                  date: date,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 練習記録セクション全体（薄い水色背景）
          _PracticeSection(
            morningTitle: morningTitle,
            morningStrength: morningStrength,
            morningContent: morningContent,
            morningComment: morningComment,
            afternoonTitle: afternoonTitle,
            afternoonStrength: afternoonStrength,
            afternoonContent: afternoonContent,
          ),
        ],
      ),
    );
  }

  String _initials(String n) {
    // "田中太郎" → "TT" っぽい2文字を丸アイコン内に表示
    if (n.length <= 2) return n;
    // characters を使うと絵文字などの結合文字も安全に扱えるが
    // ここは単純に先頭2文字でOKにする
    return n.substring(0, 2).toUpperCase();
  }
}

class _HeaderMeta extends StatelessWidget {
  final String name;
  final String grade;
  final String position;
  final String date;

  const _HeaderMeta({
    required this.name,
    required this.grade,
    required this.position,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: InsightColors.textMain,
              ),
            ),
            _SmallPill(
              text: grade,
              bg: Colors.grey.shade200,
              fg: Colors.black87,
            ),
            _SmallPill(
              text: position,
              bg: Colors.white,
              fg: Colors.blue,
              borderColor: Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              date,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PracticeSection extends StatelessWidget {
  final String morningTitle;
  final String morningStrength;
  final String morningContent;
  final String morningComment;

  final String afternoonTitle;
  final String afternoonStrength;
  final String afternoonContent;

  const _PracticeSection({
    required this.morningTitle,
    required this.morningStrength,
    required this.morningContent,
    required this.morningComment,
    required this.afternoonTitle,
    required this.afternoonStrength,
    required this.afternoonContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 薄い水色背景、角丸16px
      decoration: BoxDecoration(
        color: InsightColors.lightSectionBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // セクションタイトル「練習記録」
          Row(
            children: const [
              Icon(Icons.brightness_high, color: Colors.blueAccent),
              SizedBox(width: 8),
              Text(
                '練習記録',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 朝練ブロック
          _PracticeBlock(
            title: morningTitle,
            strength: morningStrength,
            content: morningContent,
            comment: morningComment,
          ),
          const SizedBox(height: 16),

          // 午後練ブロック
          _PracticeBlock(
            title: afternoonTitle,
            strength: afternoonStrength,
            content: afternoonContent,
            // コメント（吹き出し）は午後練には無い想定
          ),
        ],
      ),
    );
  }
}

class _PracticeBlock extends StatelessWidget {
  final String title;
  final String strength;
  final String content;
  final String? comment;

  const _PracticeBlock({
    required this.title,
    required this.strength,
    required this.content,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 内側の白いカード（角丸16）
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1行目：時間帯タイトル＋強度バッジ
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.access_time, size: 18, color: Colors.grey),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: InsightColors.intensityRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '強度 $strength/10',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // メニュー内容
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),

          // コメント（青っぽい吹き出し）
          if (comment != null && comment!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.shade100,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                '💭 $comment',
                style: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 14,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SmallPill extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;
  final Color? borderColor;

  const _SmallPill({
    required this.text,
    required this.bg,
    required this.fg,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1)
            : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}
