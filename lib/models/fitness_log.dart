import 'package:uuid/uuid.dart';

class FitnessLog {
  final String id;
  final int steps;
  final DateTime date;

  FitnessLog({required this.id, required this.steps, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'steps': steps,
      'date': date.toIso8601String(),
    };
  }

  factory FitnessLog.fromMap(Map<String, dynamic> map) {
    return FitnessLog(
      id: map['id'] ?? const Uuid().v4(),
      steps: map['steps'] ?? 0,
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }
}