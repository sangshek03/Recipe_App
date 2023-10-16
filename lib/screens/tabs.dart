import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categoriesScreen.dart';
import 'package:meals_app/screens/filterScreen.dart';
import 'package:meals_app/screens/mealScreen.dart';
import 'package:meals_app/widgets/mainDrawer.dart';

var kIntinalFilter = {
  Filter.vegan: false,
  Filter.glutenfree: false,
  Filter.vegetarian: false,
  Filter.lactosefree: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int selectedPageIndex = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> selectedFilters = kIntinalFilter;

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void selectFavoriteMeals(Meal meal) {
    final isMealExits = favoriteMeals.contains(meal);

    if (isMealExits) {
      setState(() {
        favoriteMeals.remove(meal);
        showMessage('Meal is Removed from Favorite Lise');
      });
    } else {
      setState(() {
        favoriteMeals.add(meal);
        showMessage('Meal is Added to Favorite List');
      });
    }
  }

  void _selectPage(index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  void onSelectScreen(String indentifer) async {
    Navigator.of(context).pop();

    if (indentifer == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    currentFilters: selectedFilters,
                  )));

      setState(() {
        selectedFilters = result ?? kIntinalFilter;
      });
      // print(selectedFilters);
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (selectedFilters[Filter.glutenfree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (selectedFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();

    Widget content = CategoriesScreen(
      togglefavorites: selectFavoriteMeals,
      avilableMeals: availableMeals,
    );
    String pageTitle = 'Pick Your Categories';

    if (selectedPageIndex == 1) {
      content = MealScreen(
        meals: favoriteMeals,
        togglefavorites: selectFavoriteMeals,
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
