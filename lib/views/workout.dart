import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:strength_log_book/models/workout_plan.dart';
import 'package:strength_log_book/services/database_service.dart';

class Workoutday extends StatefulWidget {
  final WorkoutDay day;
  final WorkoutPlan plan;
  final DatabaseService database;

  const Workoutday({
    super.key,
    required this.day,
    required this.plan,
    required this.database,
  });

  @override
  State<Workoutday> createState() => _WorkoutdayState();
}

class _WorkoutdayState extends State<Workoutday> {
  Future<void> savePlan() async {
    await widget.database.savePlan(widget.plan);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await savePlan();
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.day.dayName)),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    for (final exercise in widget.day.exercises)
                      ListTile(
                        title: Text(exercise.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final setEntry
                                in exercise.sets.asMap().entries)
                              Row(
                                children: [
                                  Text("Set ${setEntry.key + 1}"),

                                  const SizedBox(width: 20),

                                  GestureDetector(
                                    onTap: () {
                                      _showWeightPicker(
                                        context,
                                        setEntry.value,
                                      );
                                    },
                                    child: Text(
                                      "${setEntry.value.weight} kg",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 20),

                                  GestureDetector(
                                    onTap: () {
                                      _showRepsPicker(context, setEntry.value);
                                    },
                                    child: Text(
                                      "${setEntry.value.reps} reps",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await savePlan();
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  //navigate to main page when pressed
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWeightPicker(BuildContext context, ExerciseSetData set) {
    double selectedWeight = set.weight;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  DecimalNumberPicker(
                    value: selectedWeight,
                    minValue: 0,
                    maxValue: 300,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      setSheetState(() {
                        selectedWeight = value;
                      });
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        set.weight = selectedWeight;
                      });

                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showRepsPicker(BuildContext context, ExerciseSetData set) {
    double selectedReps = set.reps;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  DecimalNumberPicker(
                    value: selectedReps,
                    minValue: 0,
                    maxValue: 100,
                    decimalPlaces: 1,
                    onChanged: (value) {
                      setSheetState(() {
                        selectedReps = value;
                      });
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        set.reps = selectedReps;
                      });

                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
