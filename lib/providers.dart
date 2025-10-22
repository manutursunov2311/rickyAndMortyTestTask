import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart' show Isar;
import 'package:isar/isar.dart';
import 'package:rm_characters_test_task/core/character_dao.dart';
import 'package:rm_characters_test_task/core/rick_and_morty_api.dart';
import 'package:rm_characters_test_task/domain/character_repository.dart';
import 'package:rm_characters_test_task/models/character.dart';

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar must be initialized in main.dart');
});
final apiProvider = Provider((ref) => RickAndMortyApi());
final repositoryProvider = Provider<CharacterRepository>((ref) {
  final isar = ref.watch(isarProvider);
  final dao = CharacterDao(isar);
  return CharacterRepository(ref.watch(apiProvider), dao);
});

final charactersProvider = AsyncNotifierProvider<CharactersNotifier, List<Character>>(
  CharactersNotifier.new,
);

final favoritesProvider = AsyncNotifierProvider<FavoritesNotifier, List<Character>>(
  FavoritesNotifier.new,
);

final isCharacterFavoriteProvider = FutureProvider.family.autoDispose<bool, int>((ref, characterId) async {
  final repository = ref.watch(repositoryProvider);
  return await repository.isFavorite(characterId);
});

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

enum SortType { name, status, species }

final sortTypeProvider = StateProvider<SortType>((ref) => SortType.name);

class CharactersNotifier extends AsyncNotifier<List<Character>> {
  int _page = 1;
  final List<Character> _characters = [];
  bool _isLoadingMore = false;

  @override
  Future<List<Character>> build() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(repositoryProvider);
      final newCharacters = await repository.getCharacters(_page, forceRefresh: false);
      _characters.addAll(newCharacters);
      _page++;
      return _characters;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return _characters;
    }
  }

  Future<void> loadCharacters({bool isRefresh = false}) async {
    if (_isLoadingMore && !isRefresh) return;

    if (isRefresh) {
      _page = 1;
      _characters.clear();
      state = const AsyncValue.loading();
    } else {
      _isLoadingMore = true;
    }

    try {
      final repository = ref.read(repositoryProvider);
      final newCharacters = await repository.getCharacters(_page, forceRefresh: isRefresh);
      _characters.addAll(newCharacters);
      state = AsyncValue.data(List.from(_characters));
      _page++;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      _isLoadingMore = false;
    }
  }
}

class FavoritesNotifier extends AsyncNotifier<List<Character>> {
  @override
  Future<List<Character>> build() async {
    final repository = ref.watch(repositoryProvider);
    return await repository.getFavorites();
  }

  Future<void> loadFavorites() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(repositoryProvider);
      final favorites = await repository.getFavorites();
      state = AsyncValue.data(favorites);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> toggleFavorite(int characterId, bool isFavorite) async {
    try {
      final repository = ref.read(repositoryProvider);
      await repository.toggleFavorite(characterId, isFavorite);
      await loadFavorites();
      ref.invalidate(isCharacterFavoriteProvider(characterId));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}