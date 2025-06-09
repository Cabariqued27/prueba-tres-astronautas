import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final favoritePlanetsProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  static const boxName = 'favorites';
  late Box<String> _box;

  FavoritesNotifier() : super({}) {
    _init();
  }

  Future<void> _init() async {
    _box = Hive.box<String>(boxName);
    final favorites = _box.values.toSet();
    state = favorites;
  }

  Future<void> toggleFavorite(String planetId) async {
    final current = Set<String>.from(state);
    if (current.contains(planetId)) {
      current.remove(planetId);
      await _box.delete(planetId);
    } else {
      current.add(planetId);
      await _box.put(planetId, planetId);
    }
    state = current;
  }

  bool isFavorite(String planetId) {
    return state.contains(planetId);
  }
}
