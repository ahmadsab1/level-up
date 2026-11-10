class Player {
  final int level;
  final int xp;       // الـ XP جوه الليفل الحالي
  final int totalXp;  // كل الـ XP من أول ما بدأت

  const Player({this.level = 1, this.xp = 0, this.totalXp = 0});

  // الـ XP المطلوب عشان تطلع الليفل اللي بعده
  int get xpToNext => 100 + (level - 1) * 50;

  // نسبة التقدم للـ progress bar (من 0 لـ 1)
  double get progress => xp / xpToNext;

  Player copyWith({int? level, int? xp, int? totalXp}) => Player(
    level: level ?? this.level,
    xp: xp ?? this.xp,
    totalXp: totalXp ?? this.totalXp,
  );
}