import 'package:isar/isar.dart';
import 'package:rm_characters_test_task/models/location_schema.dart';

part 'character_schema.g.dart';

@collection
class CharacterSchema {
  Id id = Isar.autoIncrement;
  @Index()
  late int apiId;
  late String name;
  late String status;
  late String species;
  late String image;
  LocationSchema? location;
}
