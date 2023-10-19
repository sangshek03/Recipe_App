import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/categoryitems.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/mealScreen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.avilableMeals});

  final List<Meal> avilableMeals;

  void _selectedScreen(BuildContext context, Category category) {
    final filteredMeal = avilableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // print(filteredMeal);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MealScreen(
                  title: category.title,
                  meals: filteredMeal,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          // mainAxisExtent: 100,
        ),
        children: [
          // map.availableCategorgies((e) => CategoryGridItem(category: e))).toList(); Alternative
          for (Category category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectedScreen: () {
                _selectedScreen(context, category);
              },
            )
        ]);
  }
}
