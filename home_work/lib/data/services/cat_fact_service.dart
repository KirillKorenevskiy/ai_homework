import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/providers/models/cat_fact.dart';

class CatFactService {
  static const String _baseUrl = 'https://catfact.ninja';
  final http.Client _client;

  CatFactService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<CatFact>> getFacts({int limit = 10}) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/facts?limit=$limit'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> facts = data['data'] ?? [];
        return facts.map((json) => CatFact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load facts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load facts: $e');
    }
  }

  Future<CatFact> getRandomFact() async {
    try {
      final response = await _client.get(Uri.parse('$_baseUrl/fact'));

      if (response.statusCode == 200) {
        return CatFact.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load random fact: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load random fact: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
