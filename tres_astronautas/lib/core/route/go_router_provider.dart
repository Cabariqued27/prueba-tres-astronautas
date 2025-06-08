import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/core/route/route_name.dart';
import 'package:tres_astronautas/features/home/home_screen.dart';
import 'package:tres_astronautas/features/home/not_found_screen.dart';
import 'package:tres_astronautas/features/planets/presentation/planet_detail_screen.dart';
import 'package:tres_astronautas/features/planets/presentation/planet_list_screen.dart';
import 'package:tres_astronautas/data/models/models_planets.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/home',
        name: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: '/planets',
        name: planetsRoute,
        builder: (context, state) => const PlanetListScreen(),
        routes: [
          GoRoute(
            path: ':planetId',
            name: 'planet_detail',
            builder: (context, state) {
              final planet = state.extra as Planet?;
              if (planet == null) {
                return const NotFoundScreen();
              }
              return PlanetDetailScreen(planet: planet); 
            },
          ),
        ],
      ),
    ],
  );
});
