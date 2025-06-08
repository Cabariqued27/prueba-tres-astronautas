import 'package:flutter/material.dart';
import 'package:tres_astronautas/data/models/models_planets.dart';
import 'package:tres_astronautas/utils/responsive_design.dart';

class PlanetDetailScreen extends StatelessWidget {
  final Planet planet;

  const PlanetDetailScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planet.name ?? '')),
      body: Resizer(
        compact: _buildCompactView(planet),
        medium: _buildSideBySideView(planet, imageHeight: double.infinity),
        expanded: _buildSideBySideView(planet, imageHeight: 300),
      ),
    );
  }

  Widget _buildCompactView(Planet planet) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlanetHeader(planet: planet, imageHeight: 200),
          const SizedBox(height: 16),
          ..._buildPlanetDetails(planet),
        ],
      ),
    );
  }

  Widget _buildSideBySideView(Planet planet, {required double imageHeight}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _PlanetHeader(planet: planet, imageHeight: imageHeight),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildPlanetDetails(planet),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPlanetDetails(Planet planet) {
    return [
      const SizedBox(height: 16),
      Text(planet.description ?? ''),
      const SizedBox(height: 24),
      const Text(
        'Datos clave',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text('Distancia orbital: ${planet.orbitalDistanceKm} km'),
      Text('Radio ecuatorial: ${planet.equatorialRadiusKm} km'),
      Text('Volumen: ${planet.volumeKm3} km³'),
      Text('Masa: ${planet.massKg} kg'),
      Text('Densidad: ${planet.densityGcm3} g/cm³'),
      Text('Gravedad superficial: ${planet.surfaceGravityMs2} m/s²'),
      Text('Velocidad de escape: ${planet.escapeVelocityKmh} km/h'),
      Text('Duración del día: ${planet.dayLengthEarthDays} días terrestres'),
      Text('Duración del año: ${planet.yearLengthEarthDays} días terrestres'),
      Text('Velocidad orbital: ${planet.orbitalSpeedKmh} km/h'),
      Text('Composición atmosférica: ${planet.atmosphereComposition}'),
      Text('Número de lunas: ${planet.moons}'),
      const SizedBox(height: 24),
      ElevatedButton.icon(
        onPressed: () {
          // TODO: lógica para marcar como favorito
        },
        icon: const Icon(Icons.favorite_border),
        label: const Text('Marcar como favorito'),
      ),
    ];
  }
}

class _PlanetHeader extends StatelessWidget {
  final Planet planet;
  final double imageHeight;

  const _PlanetHeader({required this.planet, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          planet.name ?? '',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Image.network(
          planet.image??'',
          height: imageHeight,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Text('Error al cargar imagen'),
        ),
      ],
    );
  }
}
