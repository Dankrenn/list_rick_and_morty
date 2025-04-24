import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:list_rick_and_morty/model/person.dart';

class NetworkService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Person>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/character?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List).map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
