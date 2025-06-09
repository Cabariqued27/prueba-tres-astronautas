import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tres_astronautas/core/controllers/favorite_planets_provider.dart';
import 'package:tres_astronautas/data/models/planet_model.dart';
import 'package:tres_astronautas/utils/responsive_design.dart';

class PlanetDetailScreen extends ConsumerWidget {
  final Planet planet;

  const PlanetDetailScreen({super.key, required this.planet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritePlanetsProvider);
    final isFavorite = favorites.contains(planet.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(planet.name ?? ''),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Resizer(
        compact: _buildCompactView(context, ref, planet, isFavorite),
        medium: _buildSideBySideView(
          context,
          ref,
          planet,
          imageHeightRatio: 0.6,
          isFavorite: isFavorite,
        ),
        expanded: _buildSideBySideView(
          context,
          ref,
          planet,
          imageHeightRatio: 0.3,
          isFavorite: isFavorite,
        ),
      ),
    );
  }

  Widget _buildCompactView(
    BuildContext context,
    WidgetRef ref,
    Planet planet,
    bool isFavorite,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;
    final baseFontSize = (screenWidth * 0.04).clamp(12.0, 20.0); 
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PlanetHeader(planet: planet, imageHeight: screenWidth * 0.6),
          SizedBox(height: screenWidth * 0.07),
          ..._buildPlanetDetails(
            context,
            ref,
            planet,
            isFavorite,
            baseFontSize: baseFontSize,
          ),
        ],
      ),
    );
  }

  Widget _buildSideBySideView(
  BuildContext context,
  WidgetRef ref,
  Planet planet, {
  required double imageHeightRatio,
  required bool isFavorite,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final padding = screenWidth * 0.05;
  final spacing = screenWidth * 0.05;
  final imageHeight = screenWidth * imageHeightRatio;
  final baseFontSize = (screenWidth * 0.035).clamp(12.0, 18.0);

  return SingleChildScrollView( 
    padding: EdgeInsets.all(padding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _PlanetHeader(planet: planet, imageHeight: imageHeight),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildPlanetDetails(
              context,
              ref,
              planet,
              isFavorite,
              baseFontSize: baseFontSize,
            ),
          ),
        ),
      ],
    ),
  );
}


  List<Widget> _buildPlanetDetails(
    BuildContext context,
    WidgetRef ref,
    Planet planet,
    bool isFavorite, {
    required double baseFontSize,
  }) {
    final labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue.shade600,
      fontSize: baseFontSize,
    );
    final valueStyle = TextStyle(
      color: Colors.black87,
      fontSize: baseFontSize * 0.9,
    );

    Widget dataChip(String label, String value) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: baseFontSize * 0.5, 
          vertical: baseFontSize * 0.3,  
        ),
        margin: EdgeInsets.symmetric(
          horizontal: baseFontSize * 0.3, 
          vertical: baseFontSize * 0.4,   
        ),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(baseFontSize),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '$label: ', style: labelStyle),
              TextSpan(text: value, style: valueStyle),
            ],
          ),
        ),
      );
    }

    return [
      Text(
        planet.description ?? 'Descripción no disponible.',
        style: TextStyle(fontSize: baseFontSize, height: 1.4),
      ),
      SizedBox(height: baseFontSize * 2),
      Text(
        'Datos clave',
        style: TextStyle(
          fontSize: baseFontSize * 1.5,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade600,
        ),
      ),
      SizedBox(height: baseFontSize),
      Wrap(
        children: [
          dataChip(
            'Distancia orbital',
            '${planet.orbitalDistanceKm ?? "N/A"} km',
          ),
          dataChip(
            'Radio ecuatorial',
            '${planet.equatorialRadiusKm ?? "N/A"} km',
          ),
          dataChip('Volumen', '${planet.volumeKm3 ?? "N/A"} km³'),
          dataChip('Masa', '${planet.massKg ?? "N/A"} kg'),
          dataChip('Densidad', '${planet.densityGcm3 ?? "N/A"} g/cm³'),
          dataChip(
            'Gravedad superficial',
            '${planet.surfaceGravityMs2 ?? "N/A"} m/s²',
          ),
          dataChip(
            'Velocidad de escape',
            '${planet.escapeVelocityKmh ?? "N/A"} km/h',
          ),
          dataChip(
            'Duración del día',
            '${planet.dayLengthEarthDays ?? "N/A"} días',
          ),
          dataChip(
            'Duración del año',
            '${planet.yearLengthEarthDays ?? "N/A"} días',
          ),
          dataChip(
            'Velocidad orbital',
            '${planet.orbitalSpeedKmh ?? "N/A"} km/h',
          ),
          dataChip('Atmósfera', planet.atmosphereComposition ?? 'N/A'),
          dataChip('Lunas', '${planet.moons ?? "0"}'),
        ],
      ),
      SizedBox(height: baseFontSize * 2.5),
      ElevatedButton.icon(
        onPressed: () {
          ref
              .read(favoritePlanetsProvider.notifier)
              .toggleFavorite(planet.name ?? '');
        },
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
          size: baseFontSize * 1.2,
        ),
        label: Text(
          isFavorite ? 'Quitar de favoritos' : 'Marcar como favorito',
          style: TextStyle(fontSize: baseFontSize * 1.1),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: baseFontSize * 3,
            vertical: baseFontSize,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
        ),
      ),

      SizedBox(height: baseFontSize * 2),
    ];
  }
}

class _PlanetHeader extends StatelessWidget {
  final Planet planet;
  final double imageHeight;

  const _PlanetHeader({required this.planet, required this.imageHeight});

  @override
  Widget build(BuildContext context) {
    final borderRadius = imageHeight * 0.07;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      shadowColor: Colors.blue.shade600,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              planet.image ?? '',
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: imageHeight,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Text(
                  'Imagen no disponible',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(imageHeight * 0.07),
              child: Text(
                planet.name ?? 'Sin nombre',
                style: TextStyle(
                  fontSize: imageHeight * 0.15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
