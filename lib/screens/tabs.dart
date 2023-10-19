import 'package:flutter/material.dart';
// import 'package:meals_app/data/dummy_data.dart';
// import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favoritesMeals_provider.dart';
import 'package:meals_app/screens/categoriesScreen.dart';
import 'package:meals_app/screens/filterScreen.dart';
import 'package:meals_app/screens/mealScreen.dart';
import 'package:meals_app/widgets/mainDrawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filter_provider.dart';

var kIntinalFilter = {
  Filter.vegan: false,
  Filter.glutenfree: false,
  Filter.vegetarian: false,
  Filter.lactosefree: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int selectedPageIndex = 0;

  void _selectPage(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void onSelectScreen(String indentifer) async {
    Navigator.of(context).pop();

    if (indentifer == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));

      // print(selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget content = CategoriesScreen(
      avilableMeals: availableMeals,
    );
    String pageTitle = 'Pick Your Categories';

    if (selectedPageIndex == 1) {
      final favoritesMeals = ref.watch(favoritesMealsProvider);

      content = MealScreen(
        meals: favoritesMeals,
      );
      pageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      drawer: MainDrawer(
        onSelectScreen: onSelectScreen,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (idx) {
            _selectPage(idx);
          },
          currentIndex: selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ]),
    );
  }
}
