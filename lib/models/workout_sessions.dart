//Plan where all the exercises are in for the workout
class WorkoutSession {
  final DateTime date;
  final String dayName;
  final Map<String, List<int>> exercises;

  const WorkoutSession({
    required this.date,
    required this.dayName,
    required this.exercises,
  });
}
