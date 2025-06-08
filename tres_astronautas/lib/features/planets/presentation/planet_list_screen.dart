import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/features/planets/application/planet_provider.dart';

class PlanetListScreen extends ConsumerStatefulWidget {
  const PlanetListScreen({super.key});

  @override
  ConsumerState<PlanetListScreen> createState() => _PlanetListScreenState();
}

class _PlanetListScreenState extends ConsumerState<PlanetListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final planetsAsync = ref.watch(planetListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Planetas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar planeta...',
                border: OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: planetsAsync.when(
              data: (planets) {
                final filteredPlanets = planets.where((planet) {
                  return planet.name!.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filteredPlanets.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron planetas'),
                  );
                }

                return ListView.builder(
                  itemCount: filteredPlanets.length,
                  itemBuilder: (context, index) {
                    final planet = filteredPlanets[index];
                    return ListTile(
                      title: Text(planet.name ?? ''),
                      onTap: () => context.pushNamed(
                        'planet_detail',
                        pathParameters: {
                          'planetId': planet.name!.toLowerCase(),
                        },
                        extra: planet, // ← pasamos el objeto completo
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
