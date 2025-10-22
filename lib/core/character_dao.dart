import 'package:isar/isar.dart';
import 'package:rm_characters_test_task/models/character_schema.dart';
import 'package:rm_characters_test_task/models/favorite_schema.dart';
import 'package:rm_characters_test_task/models/location.dart';
import 'package:rm_characters_test_task/models/location_schema.dart';
import '../models/character.dart';

class CharacterDao {
  final Isar isar;

  CharacterDao(this.isar);

  Future<void> saveCharacters(List<Character> characters) async {
    await isar.writeTxn(() async {
      await isar.characterSchemas.putAll(
        characters
            .map(
              (c) => CharacterSchema()
            ..apiId = c.id
            ..name = c.name
            ..status = c.status
            ..species = c.species
            ..image = c.image
            ..location = (LocationSchema()
              ..name = c.location.name
              ..url = c.location.url),
        )
            .toList(),
      );
    });
  }

  Future<List<Character>> getCharacters() async {
    final schemas = await isar.characterSchemas.where().findAll();
    return schemas
        .map(
          (s) => Character(
        id: s.apiId,
        name: s.name,
        status: s.status,
        species: s.species,
        image: s.image,
        location: Location(
          name: s.location?.name ?? '',
          url: s.location?.url ?? '',
        ),
      ),
    )
        .toList();
  }

  Future<void> addFavorite(int characterId) async {
    await isar.writeTxn(() async {
      final existing = await isar.favoriteSchemas
          .where()
          .characterIdEqualTo(characterId)
          .findFirst();

      if (existing == null) {
        await isar.favoriteSchemas.put(
          FavoriteSchema()..characterId = characterId,
        );
      }
    });
  }

  Future<void> removeFavorite(int characterId) async {
    await isar.writeTxn(() async {
      await isar.favoriteSchemas
          .where()
          .characterIdEqualTo(characterId)
          .deleteAll();
    });
  }

  Future<bool> isFavorite(int characterId) async {
    final favorite = await isar.favoriteSchemas
        .where()
        .characterIdEqualTo(characterId)
        .findFirst();
    return favorite != null;
  }

  Future<List<Character>> getFavorites() async {
    final favorites = await isar.favoriteSchemas.where().findAll();

    if (favorites.isEmpty) {
      return [];
    }

    final characterIds = favorites.map((f) => f.characterId).toSet().toList();
    final List<Character> characters = [];

    for (final id in characterIds) {
      final schema = await isar.characterSchemas
          .where()
          .apiIdEqualTo(id)
          .findFirst();

      if (schema != null) {
        characters.add(
          Character(
            id: schema.apiId,
            name: schema.name,
            status: schema.status,
            species: schema.species,
            image: schema.image,
            location: Location(
              name: schema.location?.name ?? '',
              url: schema.location?.url ?? '',
            ),
          ),
        );
      }
    }

    return characters;
  }
}