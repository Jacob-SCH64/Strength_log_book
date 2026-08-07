import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:strength_log_book/models/workout_plan.dart';
import 'package:strength_log_book/views/overview.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationSupportDirectory();

  isar = await Isar.open([WorkoutPlanSchema], directory: dir.path);

  runApp(MyApp(isar: isar));
}
