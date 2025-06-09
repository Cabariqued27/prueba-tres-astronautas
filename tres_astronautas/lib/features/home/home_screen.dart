import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tres_astronautas/core/route/route_name.dart';
import 'package:tres_astronautas/utils/responsive_design.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Resizer(
        compact: _buildCompact(context),
        medium: _buildMedium(context),
        expanded: _buildExpanded(context),
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Compact View (Mobile)'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.goNamed(planetsRoute),
            child: const Text('Ver Planetas'),
          ),
        ],
      ),
    );
  }

  Widget _buildMedium(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Medium View (Tablet Portrait)'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>context.goNamed(planetsRoute),
            child: const Text('Ver Planetas'),
          ),
        ],
      ),
    );
  }

  Widget _buildExpanded(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text('Expanded View (Tablet Landscape / Desktop)'),
          ElevatedButton(
            onPressed: () => context.goNamed(planetsRoute),
            child: const Text('Ver Planetas'),
          ),
          const Icon(Icons.desktop_windows, size: 50),
        ],
      ),
    );
  }
}
