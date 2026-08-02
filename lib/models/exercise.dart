class Exercise {
  final String name;
  final String type;
  final List<ExerciseSet> sets;

  const Exercise({required this.name, required this.type, required this.sets});

  factory Exercise.fromJson(String name, Map<String, dynamic> json) {
    return Exercise(
      name: name,
      type: json['type'] ?? '',
      sets: (json['sets'] as List)
          .map((set) => ExerciseSet.fromJson(set))
          .toList(),
    );
  }

  Exercise copyWith({String? name, String? type, List<ExerciseSet>? sets}) {
    return Exercise(
      name: name ?? this.name,
      type: type ?? this.type,
      sets: sets ?? this.sets,
    );
  }
}

class ExerciseSet {
  final double weight;
  final int reps;

  const ExerciseSet({required this.weight, required this.reps});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      weight: (json['weight'] ?? 0).toDouble(),
      reps: json['reps'],
    );
  }

  ExerciseSet copyWith({double? weight, int? reps}) {
    return ExerciseSet(weight: weight ?? this.weight, reps: reps ?? this.reps);
  }
}
