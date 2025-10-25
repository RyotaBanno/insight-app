class Comment {
  final String authorId;
  final String text;
  final bool isCoach; // 顧問コメントかどうか
  final DateTime createdAt;

  const Comment({
    required this.authorId,
    required this.text,
    required this.isCoach,
    required this.createdAt,
  });
}
