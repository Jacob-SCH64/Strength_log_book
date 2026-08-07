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

  Exercise addRep(int setIndex, double reps) {
    final newSets = [...sets];
    newSets[setIndex] = newSets[setIndex].copyWith(reps: reps);

    return copyWith(sets: newSets);
  }

  Exercise updateWeight(int setIndex, double weight) {
    final newSets = [...sets];
    newSets[setIndex] = newSets[setIndex].copyWith(weight: weight);

    return copyWith(sets: newSets);
  }
}

class ExerciseSet {
  final double weight;
  final double reps;

  const ExerciseSet({required this.weight, required this.reps});

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      weight: (json['weight'] ?? 0).toDouble(),
      reps: json['reps'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'weight': weight, 'reps': reps};
  }

  ExerciseSet copyWith({double? weight, double? reps}) {
    return ExerciseSet(weight: weight ?? this.weight, reps: reps ?? this.reps);
  }
}
