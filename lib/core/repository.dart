import '../models/user.dart';
import '../models/post.dart';
import '../models/comment.dart';

class InsightRepository {
  User? _currentUser;
  final List<Post> _posts = [];

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<User?> login(
      {required String userId, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final isCoach = userId.contains('coach');
    final role = isCoach ? UserRole.coach : UserRole.student;

    _currentUser = User(
      id: userId,
      displayName: userId.toUpperCase(),
      role: role,
      grade: role == UserRole.student ? 2 : null,
    );
    return _currentUser;
  }

  Future<List<Post>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 250));
    _posts.sort((a, b) => b.date.compareTo(a.date));
    return List.unmodifiable(_posts);
  }

  Future<Post> createPost(Post draft) async {
    await Future.delayed(const Duration(milliseconds: 300));

    String dayKey(DateTime d) => '${d.year}-${d.month}-${d.day}';
    final exists = _posts.any(
      (p) => p.userId == draft.userId && dayKey(p.date) == dayKey(draft.date),
    );

    if (exists) {
      throw Exception('本日は既に投稿済みです（1日1件制約）');
    }

    final created = draft.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _posts.add(created);
    return created;
  }

  Future<void> addComment({
    required String postId,
    required Comment comment,
  }) async {
    final index = _posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;
    final p = _posts[index];
    final updated = p.copyWith(comments: [...p.comments, comment]);
    _posts[index] = updated;
  }

  Future<String> fetchAiAnalysis({required String userId}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return '今週は打撃比率が高く睡眠時間が短めです。疲労回復を優先し、炭水化物とたんぱく質の比率を見直しましょう。';
  }
}
