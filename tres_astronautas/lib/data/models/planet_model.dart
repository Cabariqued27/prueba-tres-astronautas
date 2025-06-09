class Planet {
   String? name;
   int? orbitalDistanceKm;
   int? equatorialRadiusKm;
   String? volumeKm3;
   String? massKg;
   double? densityGcm3;
   double? surfaceGravityMs2;
   int? escapeVelocityKmh;
   double? dayLengthEarthDays;
   double? yearLengthEarthDays;
   int? orbitalSpeedKmh;
   String? atmosphereComposition;
   int? moons;
   String? image;
   String? description;

  Planet({
    required this.name,
    required this.orbitalDistanceKm,
    required this.equatorialRadiusKm,
    required this.volumeKm3,
    required this.massKg,
    required this.densityGcm3,
    required this.surfaceGravityMs2,
    required this.escapeVelocityKmh,
    required this.dayLengthEarthDays,
    required this.yearLengthEarthDays,
    required this.orbitalSpeedKmh,
    required this.atmosphereComposition,
    required this.moons,
    required this.image,
    required this.description,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'] ?? '',
      orbitalDistanceKm: json['orbital_distance_km'] ?? 0,
      equatorialRadiusKm: json['equatorial_radius_km'] ?? 0,
      volumeKm3: json['volume_km3'].toString(),
      massKg: json['mass_kg'].toString(),
      densityGcm3: (json['density_g_cm3'] ?? 0).toDouble(),
      surfaceGravityMs2: (json['surface_gravity_m_s2'] ?? 0).toDouble(),
      escapeVelocityKmh: json['escape_velocity_kmh'] ?? 0,
      dayLengthEarthDays: (json['day_length_earth_days'] ?? 0).toDouble(),
      yearLengthEarthDays: (json['year_length_earth_days'] ??
              json['year_length_earth_years'] ??
              0)
          .toDouble(),
      orbitalSpeedKmh: json['orbital_speed_kmh'] ?? 0,
      atmosphereComposition: json['atmosphere_composition'] ?? '',
      moons: json['moons'] ?? 0,
      image: json['image'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
