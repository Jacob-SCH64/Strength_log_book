import 'package:isar/isar.dart';

part 'workout_plan.g.dart';

@collection
class WorkoutPlan {
  Id id = Isar.autoIncrement;

  late String name;
  late int frequency;
  late String startDate;

  late List<String> cycle;

  List<WorkoutDay> days = [];

  WorkoutPlan();

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    final plan = WorkoutPlan();

    plan.name = json['name'];
    plan.frequency = json['frequency'];
    plan.startDate = json['startDate'];
    plan.cycle = List<String>.from(json['cycle']);

    final rawDays = json['days'] as Map<String, dynamic>;

    plan.days = rawDays.entries.map((dayEntry) {
      final day = WorkoutDay();
      day.dayName = dayEntry.key;

      final exercises = dayEntry.value as Map<String, dynamic>;

      day.exercises = exercises.entries.map((exerciseEntry) {
        final exercise = ExerciseData();
        exercise.name = exerciseEntry.key;

        final sets = exerciseEntry.value['sets'] as List<dynamic>;

        exercise.sets = sets.map((set) {
          final exerciseSet = ExerciseSetData();

          exerciseSet.weight = (set['weight'] as num).toDouble();
          exerciseSet.reps = (set['reps'] as num).toDouble();

          return exerciseSet;
        }).toList();

        return exercise;
      }).toList();

      return day;
    }).toList();

    return plan;
  }
}

@embedded
class WorkoutDay {
  late String dayName;

  List<ExerciseData> exercises = [];
}

@embedded
class ExerciseData {
  late String name;

  List<ExerciseSetData> sets = [];
}

@embedded
class ExerciseSetData {
  late double weight;

  late double reps;
}
