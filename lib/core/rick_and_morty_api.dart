import 'package:dio/dio.dart';
import '../models/character.dart';

const String baseUrl = 'https://rickandmortyapi.com/api';
const String characterPath = '/character';

class RickAndMortyApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Character>> fetchCharacters(int page) async {
    final response = await _dio.get(characterPath, queryParameters: {'page': page});
    return (response.data['results'] as List)
        .map((json) => Character.fromJson(json))
        .toList();
  }
}