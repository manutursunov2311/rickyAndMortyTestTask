import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rm_characters_test_task/widgets/character_card_item.dart';

import '../models/character.dart';
import '../providers.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  List<Character> _sortCharacters(List<Character> characters, SortType sortType) {
    final sorted = List<Character>.from(characters);
    switch (sortType) {
      case SortType.name:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.status:
        sorted.sort((a, b) => a.status.compareTo(b.status));
        break;
      case SortType.species:
        sorted.sort((a, b) => a.species.compareTo(b.species));
        break;
    }
    return sorted;
  }

  String _getSortLabel(SortType sortType) {
    switch (sortType) {
      case SortType.name:
        return 'По имени';
      case SortType.status:
        return 'По статусу';
      case SortType.species:
        return 'По виду';
    }
  }

  String _getPluralForm(int count) {
    if (count % 10 == 1 && count % 100 != 11) {
      return 'персонаж';
    } else if ([2, 3, 4].contains(count % 10) && ![12, 13, 14].contains(count % 100)) {
      return 'персонажа';
    } else {
      return 'персонажей';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final sortType = ref.watch(sortTypeProvider);

    return favorites.when(
      data: (data) {
        if (data.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_border,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 24),
                Text(
                  'Нет избранных персонажей',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Добавьте персонажей, нажав на звездочку',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final sorted = _sortCharacters(data, sortType);
        final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

        return Column(
          children: [
            if (data.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                child: Row(
                  children: [
                    Icon(Icons.sort, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Сортировка: ${_getSortLabel(sortType)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${data.length} ${_getPluralForm(data.length)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(favoritesProvider.notifier).loadFavorites(),
                child: AnimatedList(
                  key: listKey,
                  initialItemCount: sorted.length,
                  itemBuilder: (context, index, animation) => SizeTransition(
                    sizeFactor: animation,
                    child: CharacterCardItem(character: sorted[index]),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Ошибка загрузки',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              '$e',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => ref.read(favoritesProvider.notifier).loadFavorites(),
              icon: const Icon(Icons.refresh),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}