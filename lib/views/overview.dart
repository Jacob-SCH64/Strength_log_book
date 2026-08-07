import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:isar/isar.dart';

import 'package:strength_log_book/models/workout_plan.dart';
import 'package:strength_log_book/services/database_service.dart';
import 'package:strength_log_book/views/workout.dart';

class MyApp extends StatelessWidget {
  final Isar isar;
  const MyApp({super.key, required this.isar});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 65, 122, 245),
        ),
      ),
      home: MyLandingPage(
        title: 'Strength log Book',
        database: DatabaseService(isar),
      ),
    );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key, required this.title, required this.database});
  final String title;
  final DatabaseService database;

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  //List should be automatic on the right date
  WorkoutPlan? plan;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    loadPlan();
  }

  Future<void> loadPlan() async {
    var loadedPlan = await widget.database.getPlan();

    if (loadedPlan == null) {
      final jsonString = await rootBundle.loadString('assets/workoutPlan.json');

      loadedPlan = WorkoutPlan.fromJson(jsonDecode(jsonString));

      await widget.database.savePlan(loadedPlan);
    }

    setState(() {
      plan = loadedPlan;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (plan == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String title = "Current Split: ${plan!.name}";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: plan!.cycle.length,
                itemBuilder: (context, index) {
                  final dayName = plan!.cycle[index];
                  final isCurrent = index == currentIndex;

                  return Card(
                    color: isCurrent ? Colors.blue : null,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,

                      title: Center(child: Text(dayName)),

                      trailing: isCurrent
                          ? const Icon(Icons.check_circle)
                          : null,

                      onTap: () {
                        final dayName = plan!.cycle[index];
                        final workoutDay = plan!.days.firstWhere(
                          (d) => d.dayName == dayName,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Workoutday(
                              day: workoutDay,
                              plan: plan!,
                              database: widget.database,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
