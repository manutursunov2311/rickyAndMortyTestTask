import 'package:dio/dio.dart';
import 'package:rm_characters_test_task/core/character_dao.dart';
import 'package:rm_characters_test_task/core/rick_and_morty_api.dart';
import '../models/character.dart';

class CharacterRepository {
  final RickAndMortyApi api;
  final CharacterDao dao;

  CharacterRepository(this.api, this.dao);

  Future<List<Character>> getCharacters(int page, {bool forceRefresh = false}) async {
    try {
      final characters = await api.fetchCharacters(page);
      await dao.saveCharacters(characters);
      return characters;
    } catch (e) {
      if (e is DioException && page == 1) {
        return await dao.getCharacters();
      }
      rethrow;
    }
  }

  Future<void> toggleFavorite(int characterId, bool isFavorite) async {
    if (isFavorite) {
      await dao.addFavorite(characterId);
    } else {
      await dao.removeFavorite(characterId);
    }
  }

  Future<List<Character>> getFavorites() async {
    return await dao.getFavorites();
  }

  Future<bool> isFavorite(int characterId) async {
    return await dao.isFavorite(characterId);
  }
}