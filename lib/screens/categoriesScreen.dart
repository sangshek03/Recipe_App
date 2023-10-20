import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/categoryitems.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/mealScreen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.avilableMeals});

  final List<Meal> avilableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController
      _categoryAnimation; // late keyword is used jab initally toh value nahi dali but 1st tym use hoga tab isme value aa jayega

  @override
  void initState() {
    _categoryAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0, // default values
      upperBound: 1, // default values
    );
    super.initState();

    _categoryAnimation.forward();
  }

  @override
  void dispose() {
    _categoryAnimation.dispose();
    super.dispose();
  }

  void _selectedScreen(BuildContext context, Category category) {
    final filteredMeal = widget.avilableMeals
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
    return AnimatedBuilder(
      animation: _categoryAnimation,
      child: GridView(
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
          ]),
      // --------------one way------------
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(top: 100 - _categoryAnimation.value * 100),
      //   child: child,
      // ),
      //------------easier way---------------
      // ------------Slide Transition--------
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.5),
          end: const Offset(0, 0),
        ).animate(
            CurvedAnimation(parent: _categoryAnimation, curve: Curves.easeIn)),
        child: child,
      ),
      // ---------------ScaleTransition------------
      // builder: (context, child) => ScaleTransition(
      //       scale: Tween(begin: 1.5, end: 1.0).animate(_categoryAnimation),
      //       child: child,
      //     )
    );
  }
}
