enum Difficulty { easy, medium, hard }

class Task {
  final String id;
  final String title;
  final Difficulty difficulty;
  final bool done;

  const Task({
    required this.id,
    required this.title,
    this.difficulty = Difficulty.medium,
    this.done = false,
  });

  int get xp => switch (difficulty) {
    Difficulty.easy => 10,
    Difficulty.medium => 25,
    Difficulty.hard => 50,
  };

  Task copyWith({bool? done}) => Task(
    id: id,
    title: title,
    difficulty: difficulty,
    done: done ?? this.done,
  );
}