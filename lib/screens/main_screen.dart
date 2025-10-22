import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rm_characters_test_task/providers.dart';
import 'package:rm_characters_test_task/screens/favorites_screen.dart';
import 'package:rm_characters_test_task/screens/home_screen.dart';

import 'favorites_screen.dart' show FavoritesScreen;
import 'home_screen.dart' show HomeScreen;

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final sortType = ref.watch(sortTypeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Список персонажей' : 'Избранное'),
        actions: [
          if (_selectedIndex == 1)
            PopupMenuButton<SortType>(
              icon: const Icon(Icons.sort),
              tooltip: 'Сортировка',
              onSelected: (SortType type) {
                ref.read(sortTypeProvider.notifier).state = type;
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: SortType.name,
                  child: Row(
                    children: [
                      Icon(
                        sortType == SortType.name ? Icons.check : Icons.sort_by_alpha,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text('По имени'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: SortType.status,
                  child: Row(
                    children: [
                      Icon(
                        sortType == SortType.status ? Icons.check : Icons.info_outline,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text('По статусу'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: SortType.species,
                  child: Row(
                    children: [
                      Icon(
                        sortType == SortType.species ? Icons.check : Icons.pets,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text('По виду'),
                    ],
                  ),
                ),
              ],
            ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
            tooltip: 'Toggle Theme',
            onPressed: () {
              ref.read(themeModeProvider.notifier).state =
              themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главное'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Избранное'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}