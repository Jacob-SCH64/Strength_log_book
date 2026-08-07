import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<File> getWorkoutFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/workoutPlan.json');
  }

  static Future<void> saveWorkoutPlan(Map<String, dynamic> jsonData) async {
    final file = await getWorkoutFile();

    await file.writeAsString(jsonEncode(jsonData));
  }

  static Future<Map<String, dynamic>?> loadWorkoutPlan() async {
    final file = await getWorkoutFile();

    if (!await file.exists()) {
      return null;
    }

    final content = await file.readAsString();

    return jsonDecode(content);
  }
}
