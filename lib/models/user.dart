enum UserRole {
  student,
  coach,
}

class User {
  final String id;
  final String displayName;
  final UserRole role;
  final int? grade; // 学年（生徒のみ）

  const User({
    required this.id,
    required this.displayName,
    required this.role,
    this.grade,
  });
}
