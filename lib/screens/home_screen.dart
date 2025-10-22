import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rm_characters_test_task/widgets/character_card_item.dart';

import '../providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(charactersProvider.notifier).loadCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(charactersProvider);
    return characters.when(
      data: (data) {
        if (data.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => ref.read(charactersProvider.notifier).loadCharacters(isRefresh: true),
            child: Stack(
              children: [
                ListView(), // Ensures scrollable area for RefreshIndicator
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Не найдено список персонажей'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.read(charactersProvider.notifier).loadCharacters(isRefresh: true),
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => ref.read(charactersProvider.notifier).loadCharacters(isRefresh: true),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: data.length + 1, // +1 for loading indicator
            itemBuilder: (context, index) {
              if (index == data.length) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return CharacterCardItem(character: data[index]);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ошибка: $e'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(charactersProvider.notifier).loadCharacters(isRefresh: true),
              child: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}