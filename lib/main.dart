import 'package:dev/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'cubits/player_cubit.dart';
import 'cubits/tasks_cubit.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data');

  final playerCubit = PlayerCubit();
  runApp(MyApp(playerCubit: playerCubit));
}

class MyApp extends StatelessWidget {
  final PlayerCubit playerCubit;
  const MyApp({super.key, required this.playerCubit});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: playerCubit),
        BlocProvider(create: (_) => TasksCubit(playerCubit)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen': (context) => const SplashScreen(),
          '/HomeScreen': (context) => const HomeScreen(),
        },
      ),
    );
  }
}