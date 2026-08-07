import 'package:strength_log_book/models/exercise.dart';

class WorkoutPlan {
  final String name;
  final int frequency;
  final List<String> cycle;
  final Map<String, Map<String, Exercise>> days;
  final String startDate;

  const WorkoutPlan({
    required this.name,
    required this.frequency,
    required this.cycle,
    required this.days,
    required this.startDate,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    final rawDays = json['days'] as Map<String, dynamic>;

    return WorkoutPlan(
      name: json['name'],
      frequency: json['frequency'],
      startDate: json['startDate'],
      cycle: List<String>.from(json['cycle']),

      days: rawDays.map((dayName, exercises) {
        final exerciseMap = exercises as Map<String, dynamic>;

        return MapEntry(
          dayName,
          exerciseMap.map((exerciseName, data) {
            return MapEntry(
              exerciseName,
              Exercise.fromJson(exerciseName, data),
            );
          }),
        );
      }),
    );
  }

  Map<String, Exercise> getExercisesForDay(String dayName) {
    return days[dayName] ?? {};
  }
}

int getCurrentIndex(WorkoutPlan plan) {
  final startDate = DateTime.parse(plan.startDate);
  final today = DateTime.now();

  final difference = today.difference(startDate).inDays;

  return difference % plan.cycle.length;
}
