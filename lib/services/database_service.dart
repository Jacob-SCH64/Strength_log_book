import 'package:isar/isar.dart';
import '../models/workout_plan.dart';

class DatabaseService {
  final Isar isar;

  DatabaseService(this.isar);

  Future<WorkoutPlan?> getPlan() async {
    return await isar.workoutPlans.where().findFirst();
  }

  Future<void> savePlan(WorkoutPlan plan) async {
    await isar.writeTxn(() async {
      await isar.workoutPlans.put(plan);
    });
  }
}
