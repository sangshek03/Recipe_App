import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter { vegan, vegetarian, glutenfree, lactosefree }

class FiltersNotifer extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifer()
      : super({
          Filter.glutenfree: false,
          Filter.lactosefree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  // this method for init state
  void setFilter(Filter filter, bool isactive) {
    // state[filter] = isactive (not allowed => this is mutating state we can only immutate in this package)
    state = {...state, filter: isactive};
  }

  // this method for Willpopscope (jab back aate h toh sabhi filter ki state check krte h tab)
  void setAllFilters(Map<Filter, bool> choosenFilterMap) {
    state = choosenFilterMap; // (yaha simple new filter jo mila usse daal re)
  }

  // for star icon
  
}

final filterProvider = StateNotifierProvider<FiltersNotifer, Map<Filter, bool>>(
  (ref) => FiltersNotifer(),
);

final filteredMealsProvider = Provider((ref) {
  final dummaymealsprovider = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);

  return dummaymealsprovider.where((meal) {
    if (activeFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    return true;
  }).toList();
});
