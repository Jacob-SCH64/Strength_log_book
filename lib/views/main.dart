import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:strength_log_book/models/workout_plan.dart';
import 'package:strength_log_book/views/workout.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 65, 122, 245),
        ),
      ),
      home: const MyLandingPage(title: 'Strength log Book'),
    );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({super.key, required this.title});
  final String title;

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
    final jsonString = await rootBundle.loadString('assets/workoutPlan.json');

    final data = jsonDecode(jsonString);
    final loadedPlan = WorkoutPlan.fromJson(data);
    setState(() {
      plan = loadedPlan;
      currentIndex = getCurrentIndex(loadedPlan);
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
                  final day = plan!.cycle[index];
                  final isCurrent = index == currentIndex;

                  return Card(
                    color: isCurrent ? Colors.blue : null,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,

                      title: Center(child: Text(day)),
                      trailing: isCurrent
                          ? const Icon(Icons.check_circle)
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Workoutday(
                              dayName: day,
                              exercisesList: plan!.days[day]!,
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
