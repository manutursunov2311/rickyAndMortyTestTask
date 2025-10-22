import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rm_characters_test_task/models/character_schema.dart';
import 'package:rm_characters_test_task/models/favorite_schema.dart';

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [CharacterSchemaSchema, FavoriteSchemaSchema],
    directory: dir.path,
  );
}