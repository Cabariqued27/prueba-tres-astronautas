import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tres_astronautas/data/models/models_planets.dart';

class PlanetApi {
  static Future<List<Planet>> fetchPlanets() async {
    final url = Uri.parse('https://us-central1-a-academia-espacial.cloudfunctions.net/planets');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List<dynamic> data = jsonBody['data'];
      return data.map((json) => Planet.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching planets: ${response.statusCode}');
    }
  }
}
