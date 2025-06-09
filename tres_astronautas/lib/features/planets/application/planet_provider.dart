import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tres_astronautas/data/datasources/planet_api.dart';
import 'package:tres_astronautas/data/models/planet_model.dart';

final planetListProvider = FutureProvider<List<Planet>>((ref) async {
  return await PlanetApi.fetchPlanets();
});

final planetSearchQueryProvider = StateProvider<String>((ref) => '');

final filteredPlanetListProvider = Provider<AsyncValue<List<Planet>>>((ref) {
  final query = ref.watch(planetSearchQueryProvider).toLowerCase().trim();
  final planetsAsync = ref.watch(planetListProvider);

  return planetsAsync.whenData((planets) {
    if (query.isEmpty) return planets;

    return planets.where((planet) {
      final fieldsToCheck = [
        planet.name,
        planet.massKg,
        planet.orbitalDistanceKm?.toString(),
        planet.equatorialRadiusKm?.toString(),
        planet.volumeKm3,
        planet.densityGcm3?.toString(),
        planet.surfaceGravityMs2?.toString(),
        planet.escapeVelocityKmh?.toString(),
        planet.dayLengthEarthDays?.toString(),
        planet.yearLengthEarthDays?.toString(),
        planet.orbitalSpeedKmh?.toString(),
        planet.atmosphereComposition,
        planet.moons?.toString(),
        planet.description,
      ];
      return fieldsToCheck.any(
        (field) => field?.toLowerCase().contains(query) ?? false,
      );
    }).toList();
  });
});

