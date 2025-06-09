import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/core/route/route_name.dart';
import 'package:tres_astronautas/features/planets/application/planet_provider.dart';

class PlanetListScreen extends ConsumerWidget {
  const PlanetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPlanetsAsync = ref.watch(filteredPlanetListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planetas'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar planeta...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (query) {
                ref.read(planetSearchQueryProvider.notifier).state = query;
              },
            ),
          ),
          Expanded(
            child: filteredPlanetsAsync.when(
              data: (planets) {
                if (planets.isEmpty) {
                  return const Center(
                    child: Text(
                      'No se encontraron planetas',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: planets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final planet = planets[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        leading:  Icon(Icons.public, color: Colors.blue.shade600),
                        title: Text(
                          planet.name ?? 'Sin nombre',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => context.goNamed(
                          planetsDetailedRoute,
                          pathParameters: {
                            'planetId': planet.name!.toLowerCase(),
                          },
                          extra: planet,
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
