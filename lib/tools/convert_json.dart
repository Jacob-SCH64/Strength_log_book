import 'dart:convert';
import 'dart:io';

void main() {
  final file = File('assets/workoutPlan.json');

  final data = jsonDecode(file.readAsStringSync());

  final days = data['days'] as Map<String, dynamic>;

  days.forEach((dayName, exercises) {
    final exerciseMap = exercises as Map<String, dynamic>;

    exerciseMap.forEach((exerciseName, value) {
      // Already converted correctly
      if (value is Map && value.containsKey('sets')) {
        return;
      }

      // Convert old format:
      // "Exercise": [11,11,11]
      if (value is List) {
        exerciseMap[exerciseName] = {
          "type": "",
          "sets": value.map((rep) {
            // Fix partially converted sets
            if (rep is Map) {
              return {"weight": rep['weight'] ?? 0, "reps": rep['reps'] ?? 0};
            }

            return {"weight": 0, "reps": rep};
          }).toList(),
        };
      }
    });
  });

  file.writeAsStringSync(const JsonEncoder.withIndent('    ').convert(data));
}
