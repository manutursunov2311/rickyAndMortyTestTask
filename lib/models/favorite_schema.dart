import 'package:isar/isar.dart';

part 'favorite_schema.g.dart';

@collection
class FavoriteSchema {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
  late int characterId;
}