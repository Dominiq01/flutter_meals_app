import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteNotifier extends StateNotifier<List<Meal>> {
  FavouriteNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((mealItem) => mealItem.id != meal.id).toList();

      return false;
    }
    state = [...state, meal];
    return true;
  }
}

final favouritesProvider = StateNotifierProvider<FavouriteNotifier, List<Meal>>(
  (ref) {
    return FavouriteNotifier();
  },
);
