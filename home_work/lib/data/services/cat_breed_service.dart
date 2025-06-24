import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/providers/models/cat_breed.dart';

class CatBreedService {
  final String baseUrl = 'https://api.thecatapi.com/v1';
  final String apiKey = 'YOUR_API_KEY'; // You'll need to get an API key from https://thecatapi.com/

  final http.Client client;

  CatBreedService({http.Client? client}) : client = client ?? http.Client();

  Future<List<CatBreed>> getBreeds() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/breeds'),
        headers: {'x-api-key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CatBreed.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load breeds: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch breeds: $e');
    }
  }

  Future<CatBreed> getBreedDetails(String breedId) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/breeds/$breedId'),
        headers: {'x-api-key': apiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return CatBreed.fromJson(data);
      } else {
        throw Exception('Failed to load breed details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch breed details: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
