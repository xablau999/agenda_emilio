// lib/models/task.dart

class Task {
  String id;
  String title;
  DateTime date;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.date,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? date,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}