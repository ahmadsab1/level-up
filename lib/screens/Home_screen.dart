import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/player_cubit.dart';
import '../cubits/tasks_cubit.dart';
import '../models/player.dart';
import '../models/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ===== كارت الليفل =====
              BlocBuilder<PlayerCubit, Player>(
                builder: (context, player) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1A33),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Level ${player.level}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: player.progress,
                          minHeight: 10,
                          backgroundColor: Colors.white12,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${player.xp} / ${player.xpToNext} XP',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ===== قائمة المهام =====
              Expanded(
                child: BlocBuilder<TasksCubit, List<Task>>(
                  builder: (context, tasks) {
                    if (tasks.isEmpty) {
                      return const Center(
                        child: Text(
                          'مفيش مهام لسه، دوس + وضيف أول مهمة 💪',
                          style: TextStyle(color: Colors.white54),
                        ),
                      );
                    }
                    return ListView(
                      children: [
                        for (final t in tasks)
                          CheckboxListTile(
                            value: t.done,
                            activeColor: Colors.amber,
                            title: Text(
                              t.title,
                              style: TextStyle(
                                color: Colors.white,
                                decoration:
                                t.done ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            subtitle: Text(
                              '+${t.xp} XP',
                              style: const TextStyle(color: Colors.amber),
                            ),
                            onChanged: t.done
                                ? null
                                : (_) =>
                                context.read<TasksCubit>().complete(t.id),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ===== زرار الإضافة =====
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    var difficulty = Difficulty.medium;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) => AlertDialog(
          title: const Text('مهمة جديدة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'اسم المهمة'),
              ),
              const SizedBox(height: 16),
              SegmentedButton<Difficulty>(
                segments: const [
                  ButtonSegment(value: Difficulty.easy, label: Text('سهلة')),
                  ButtonSegment(value: Difficulty.medium, label: Text('متوسطة')),
                  ButtonSegment(value: Difficulty.hard, label: Text('صعبة')),
                ],
                selected: {difficulty},
                onSelectionChanged: (s) => setState(() => difficulty = s.first),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = controller.text.trim();
                if (title.isEmpty) return;
                context.read<TasksCubit>().add(title, difficulty);
                Navigator.pop(dialogContext);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}