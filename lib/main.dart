import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart' show Isar;
import 'package:rm_characters_test_task/core/isar_database.dart';
import 'package:rm_characters_test_task/providers.dart';
import 'package:rm_characters_test_task/screens/main_screen.dart';

Future<Isar> initializeIsarInstance() async {
  WidgetsFlutterBinding.ensureInitialized();
  return await initializeIsar();
}

void main() async {
  final isar = await initializeIsarInstance();
  runApp(ProviderScope(
    overrides: [
      isarProvider.overrideWithValue(isar),
    ],
    child: const RickAndMortyApp(),
  ));
}

class RickAndMortyApp extends ConsumerWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 2,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          color: Colors.blueGrey,
          elevation: 2,
        ),
      ),
      themeMode: themeMode,
      home: const MainScreen(),
    );
  }
}

