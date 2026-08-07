import 'package:flutter/material.dart';
import 'package:strength_log_book/models/exercise.dart';

class Workoutday extends StatelessWidget {
  final String dayName;
  final Map<String, Exercise> exercisesList;
  const Workoutday({
    super.key,
    required this.dayName,
    required this.exercisesList,
    required this.onSubmitGuess,
  });

  final void Function(String) onSubmitGuess;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dayName)),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (final entry in exercisesList.entries)
                    ListTile(
                      title: Text(entry.key),
                      subtitle: Text(
                        entry.value.sets
                            .asMap()
                            .entries
                            .map((setEntry) {
                              final setNumber = setEntry.key + 1;
                              final set = setEntry.value;

                              return 'Set $setNumber: ${set.weight} kg * ${set.reps} reps';
                            })
                            .join('\n'),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //navigate to main page when pressed
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
