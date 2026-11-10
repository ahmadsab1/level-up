import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import 'player_cubit.dart';

class TasksCubit extends Cubit<List<Task>> {
  final PlayerCubit player;
  TasksCubit(this.player) : super(const []);

  void add(String title, Difficulty difficulty) {
    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      difficulty: difficulty,
    );
    emit([...state, task]);
  }

  void complete(String id) {
    final task = state.firstWhere((t) => t.id == id);
    if (task.done) return; // مايخدش XP مرتين
    emit([for (final t in state) t.id == id ? t.copyWith(done: true) : t]);
    player.addXp(task.xp);
  }

  void remove(String id) => emit(state.where((t) => t.id != id).toList());
}