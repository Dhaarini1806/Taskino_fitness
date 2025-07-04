import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? const Uuid().v4(),
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}