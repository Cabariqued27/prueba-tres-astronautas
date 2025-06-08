import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tres_astronautas/data/datasources/planet_api.dart';
import 'package:tres_astronautas/data/models/models_planets.dart';

final planetListProvider = FutureProvider<List<Planet>>((ref) async {
  return await PlanetApi.fetchPlanets();
});
