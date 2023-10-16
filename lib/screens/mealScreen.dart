import 'package:flutter/material.dart';
// import 'package:meals_app/Widgets/mealItem.dart';
// import 'package:meals_app/Widgets/mealItem.dart';
import 'package:meals_app/widgets/mealsItem.dart';
import 'package:meals_app/models/meal.dart';

class MealScreen extends StatelessWidget {
  const MealScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.togglefavorites});

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) togglefavorites;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Oh__No__There Is No Meal Here',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('Try to add some',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      // listview m items count dena mandatory h
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (cxt, index) => MealsItem(
                meal: meals[index],
                togglefavorites: togglefavorites,
              ));
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
