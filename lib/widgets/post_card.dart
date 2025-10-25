import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/colors.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = post.userName ?? '選手';
    final dateLabel = DateFormat('yyyy年M月d日').format(post.date);
    final gradeLabel = post.grade != null ? '${post.grade}年' : null;
    final positionLabel = post.position;

    final chips = <Widget>[];
    if (gradeLabel != null) {
      chips.add(_InfoChip(label: gradeLabel));
    }
    if (positionLabel != null && positionLabel.isNotEmpty) {
      chips.add(
        _InfoChip(
          label: positionLabel,
          leading: const Icon(
            Icons.sports_baseball_rounded,
            size: 16,
            color: InsightColors.textPrimary,
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: InsightColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: InsightColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Avatar(initials: _initials(name)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: InsightColors.textPrimary,
                      ),
                    ),
                    if (chips.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: chips,
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.more_horiz,
                    size: 20,
                    color: InsightColors.textMuted,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 16,
                        color: InsightColors.textMuted,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        dateLabel,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: InsightColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (post.practices.isNotEmpty) ...[
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: InsightColors.practiceBackground,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.fitness_center_rounded,
                          size: 20,
                          color: InsightColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '練習記録',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ...post.practices.asMap().entries.map((entry) {
                    final index = entry.key;
                    final record = entry.value;
                    final isLast = index == post.practices.length - 1;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _PracticeBlock(record: record),
                        if (!isLast) ...[
                          const SizedBox(height: 22),
                          const Divider(height: 1, color: Colors.white70),
                          const SizedBox(height: 22),
                        ],
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _initials(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '?';
    }
    final trimmed = value.trim();
    return trimmed.length <= 2 ? trimmed : trimmed.substring(0, 2).toUpperCase();
  }
}

class _Avatar extends StatelessWidget {
  final String initials;

  const _Avatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [InsightColors.primary, InsightColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: InsightColors.primary.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Widget? leading;

  const _InfoChip({required this.label, this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: InsightColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: InsightColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _PracticeBlock extends StatelessWidget {
  final PracticeRecord record;

  const _PracticeBlock({required this.record});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final title = _buildTitle();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    record.detail,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: InsightColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            _IntensityBadge(intensity: record.intensity),
          ],
        ),
        if (record.memo != null && record.memo!.trim().isNotEmpty) ...[
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: InsightColors.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chat_bubble_rounded,
                    size: 16,
                    color: InsightColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    record.memo!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: InsightColors.textPrimary,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _buildTitle() {
    final timeLabel = record.timeLabel;
    if (timeLabel != null && timeLabel.trim().isNotEmpty) {
      return '${record.title}（$timeLabel）';
    }
    return record.title;
  }
}

class _IntensityBadge extends StatelessWidget {
  final int intensity;

  const _IntensityBadge({required this.intensity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: InsightColors.primary.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              color: InsightColors.intensity,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '強度 $intensity / 10',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: InsightColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
