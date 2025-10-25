import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';

const String _gradeFilterAllValue = 'all';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedGradeFilter = _gradeFilterAllValue;
  late final List<Post> _allPosts;

  @override
  void initState() {
    super.initState();
    _allPosts = _mockPosts();
  }

  List<Post> get _filteredPosts {
    if (_selectedGradeFilter == _gradeFilterAllValue) {
      return _allPosts;
    }
    return _allPosts
        .where(
          (post) => _gradeLabel(post.grade) == _selectedGradeFilter,
        )
        .toList();
  }

  String? _gradeLabel(int? grade) {
    if (grade == null) {
      return null;
    }
    return '${grade}年';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final posts = _filteredPosts;

    return Scaffold(
      backgroundColor: InsightColors.background,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ホーム',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'チームの成長記録',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        actions: const [
          _ProfileBadge(),
          SizedBox(width: 20),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: _GradeFilterRow(
                selectedGrade: _selectedGradeFilter,
                onSelected: (grade) {
                  setState(() {
                    _selectedGradeFilter = grade;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: posts.isEmpty
                  ? Center(
                      child: Text(
                        '該当する投稿がありません',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: InsightColors.textMuted,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == posts.length - 1 ? 0 : 24,
                          ),
                          child: PostCard(post: post),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _InsightNavigationBar(theme: theme),
    );
  }

  List<Post> _mockPosts() {
    return [
      Post(
        userId: 'user-1',
        userName: '田中太郎',
        grade: 3,
        position: 'ピッチャー',
        date: DateTime(2025, 1, 24),
        practices: const [
          PracticeRecord(
            title: '朝練',
            timeLabel: '6:00-8:00',
            detail: 'キャッチボール、投球練習、体幹トレーニング',
            intensity: 8,
            memo: 'コントロールが安定してきた。ストレートの威力も上がっている感じがする。',
          ),
          PracticeRecord(
            title: '午後練',
            timeLabel: '15:00-18:00',
            detail: 'ノック、バッティング練習、実戦形式',
            intensity: 9,
          ),
        ],
      ),
      Post(
        userId: 'user-2',
        userName: '佐藤花子',
        grade: 2,
        position: 'キャッチャー',
        date: DateTime(2025, 1, 23),
        practices: const [
          PracticeRecord(
            title: '朝練',
            timeLabel: '6:30-7:30',
            detail: 'ブルペンで配球練習、コーチとのリード確認',
            intensity: 7,
            memo: 'ピッチャーの新しい変化球に合わせたミットワークを重点的に。',
          ),
          PracticeRecord(
            title: '午後練',
            timeLabel: '15:30-17:30',
            detail: '守備連携、バッティングティー、サインプレー確認',
            intensity: 6,
          ),
        ],
      ),
      Post(
        userId: 'user-3',
        userName: '鈴木一郎',
        grade: 1,
        position: 'ショート',
        date: DateTime(2025, 1, 22),
        practices: const [
          PracticeRecord(
            title: '朝練',
            timeLabel: '6:00-7:45',
            detail: 'フットワークドリル、ゴロ捕球、送球練習',
            intensity: 6,
          ),
          PracticeRecord(
            title: '夕練',
            timeLabel: '17:00-18:30',
            detail: 'バッティングマシン、走塁練習、サードとの連携確認',
            intensity: 7,
            memo: '初動のスピードを上げるためにスタート姿勢を意識したい。',
          ),
        ],
      ),
      Post(
        userId: 'user-4',
        userName: '高橋未来',
        grade: 3,
        position: '外野手',
        date: DateTime(2025, 1, 20),
        practices: const [
          PracticeRecord(
            title: '午前練',
            timeLabel: '9:00-11:30',
            detail: '遠投、守備位置調整、フェンス際キャッチ練習',
            intensity: 7,
          ),
          PracticeRecord(
            title: '午後練',
            timeLabel: '14:00-16:00',
            detail: 'バッティングローテーション、走り込み',
            intensity: 8,
            memo: '打球が伸びる角度が安定してきた。下半身の使い方を継続チェック。',
          ),
        ],
      ),
    ];
  }
}

class _ProfileBadge extends StatelessWidget {
  const _ProfileBadge();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [InsightColors.primary, InsightColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: InsightColors.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'I',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradeFilterRow extends StatelessWidget {
  final String selectedGrade;
  final ValueChanged<String> onSelected;

  const _GradeFilterRow({
    required this.selectedGrade,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    const options = [
      _GradeOption(label: '全体', value: _gradeFilterAllValue),
      _GradeOption(label: '3年', value: '3年'),
      _GradeOption(label: '2年', value: '2年'),
      _GradeOption(label: '1年', value: '1年'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: InsightColors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: InsightColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: options
            .map(
              (option) => Expanded(
                child: _GradeChip(
                  label: option.label,
                  active: option.value == selectedGrade,
                  onTap: () => onSelected(option.value),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _GradeOption {
  final String label;
  final String value;

  const _GradeOption({required this.label, required this.value});
}

class _GradeChip extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _GradeChip({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Ink(
            height: 44,
            decoration: BoxDecoration(
              color: active ? InsightColors.textPrimary : InsightColors.chipBackground,
              borderRadius: BorderRadius.circular(20),
              border: active
                  ? null
                  : Border.all(color: InsightColors.border.withOpacity(0.6)),
            ),
            child: Center(
              child: Text(
                label,
                style: textStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : InsightColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InsightNavigationBar extends StatelessWidget {
  final ThemeData theme;

  const _InsightNavigationBar({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: InsightColors.surface,
        border: Border(top: BorderSide(color: InsightColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              _NavItem(
                icon: Icons.home_filled,
                label: 'ホーム',
                active: true,
                theme: theme,
              ),
              _NavItem(
                icon: Icons.add_circle_outline,
                label: '投稿',
                theme: theme,
              ),
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: '分析',
                theme: theme,
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                label: '設定',
                theme: theme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final ThemeData theme;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? theme.colorScheme.primary : InsightColors.textMuted;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
