import 'comment.dart';

class PracticeRecord {
  final String title;
  final String? timeLabel;
  final String detail;
  final String? memo;
  final int intensity;

  const PracticeRecord({
    required this.title,
    this.timeLabel,
    required this.detail,
    required this.intensity,
    this.memo,
  });
}

class Post {
  final String? id;
  final String userId;
  final String? userName;
  final int? grade;
  final String? position;
  final DateTime date;
  final List<PracticeRecord> practices;

  // 旧フォーム用フィールド（今後の互換性保持）
  final String? trainingCategory;
  final String? trainingDetail;
  final String? insights; // 自己分析
  final int? intensity; // 1-5

  // カード2：食事・体調
  final String? mealsNote;
  final double? weight;
  final double? sleepHours;
  final int? energyLevel; // 1-5
  final double? muscle;
  final double? water;
  final double? bodyFat;
  final double? bmi;

  // コメント一覧
  final List<Comment> comments;

  const Post({
    this.id,
    required this.userId,
    this.userName,
    this.grade,
    this.position,
    required this.date,
    this.practices = const [],
    this.trainingCategory,
    this.trainingDetail,
    this.insights,
    this.intensity,
    this.mealsNote,
    this.weight,
    this.sleepHours,
    this.energyLevel,
    this.muscle,
    this.water,
    this.bodyFat,
    this.bmi,
    this.comments = const [],
  });

  Post copyWith({
    String? id,
    String? userId,
    String? userName,
    int? grade,
    String? position,
    DateTime? date,
    List<PracticeRecord>? practices,
    String? trainingCategory,
    String? trainingDetail,
    String? insights,
    int? intensity,
    String? mealsNote,
    double? weight,
    double? sleepHours,
    int? energyLevel,
    double? muscle,
    double? water,
    double? bodyFat,
    double? bmi,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      grade: grade ?? this.grade,
      position: position ?? this.position,
      date: date ?? this.date,
      practices: practices ?? this.practices,
      trainingCategory: trainingCategory ?? this.trainingCategory,
      trainingDetail: trainingDetail ?? this.trainingDetail,
      insights: insights ?? this.insights,
      intensity: intensity ?? this.intensity,
      mealsNote: mealsNote ?? this.mealsNote,
      weight: weight ?? this.weight,
      sleepHours: sleepHours ?? this.sleepHours,
      energyLevel: energyLevel ?? this.energyLevel,
      muscle: muscle ?? this.muscle,
      water: water ?? this.water,
      bodyFat: bodyFat ?? this.bodyFat,
      bmi: bmi ?? this.bmi,
      comments: comments ?? this.comments,
    );
  }
}
