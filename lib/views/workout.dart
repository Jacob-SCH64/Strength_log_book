import 'package:flutter/material.dart';

class Workoutday extends StatelessWidget {
  final String dayName;
  final Map<String, List<int>> exercisesList;
  const Workoutday({
    super.key,
    required this.dayName,
    required this.exercisesList,
  });

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
                    ListTile(title: Text('${entry.key}: ${entry.value}')),
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
