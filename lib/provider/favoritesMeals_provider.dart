import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesMealsNotifer extends StateNotifier<List<Meal>> {
// it require intial state and final state of passed parameter

  FavoritesMealsNotifer() : super([]); // intial state

  bool toggleMealFavoriteStatus(Meal meal) {
    // state m change, isme hame list ko add ya remove nahi kr sakte, No updatation allowed int this package so we have to return new list
    final isFavoritemeal = state.contains(meal);

    if (isFavoritemeal) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; // this work on remove
    } else {
      state = [
        ...state,
        meal
      ]; // work on add meal (we don not update list in this pacakge so returning new one)
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifer, List<Meal>>((ref) {
  return FavoritesMealsNotifer();
});
