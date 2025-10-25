import 'comment.dart';

class Post {
  final String? id;
  final String userId;
  final DateTime date;

  // カード1：練習・気づき
  final String trainingCategory;
  final String trainingDetail;
  final String insights; // 自己分析
  final int intensity; // 1-5

  // カード2：食事・体調
  final String mealsNote;
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
    required this.date,
    required this.trainingCategory,
    required this.trainingDetail,
    required this.insights,
    required this.intensity,
    required this.mealsNote,
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
    DateTime? date,
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
      date: date ?? this.date,
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
