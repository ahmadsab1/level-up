import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/player.dart';

class PlayerCubit extends Cubit<Player> {
  PlayerCubit() : super(const Player());

  void addXp(int amount) {
    var level = state.level;
    var xp = state.xp + amount;

    // ممكن تطلع أكتر من ليفل مرة واحدة
    while (xp >= 100 + (level - 1) * 50) {
      xp -= 100 + (level - 1) * 50;
      level++;
    }

    emit(state.copyWith(
      level: level,
      xp: xp,
      totalXp: state.totalXp + amount,
    ));
  }
}