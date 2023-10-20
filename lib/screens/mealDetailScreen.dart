import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/favoritesMeals_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesMeals = ref.watch(favoritesMealsProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoritesMealsProvider.notifier)
                    .toggleMealFavoriteStatus(meal);

                // print(wasAdded ? 'true' : 'false');

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? 'Meal is Added to Favorites'
                        : 'Meal is Removed from Favorites')));
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return RotationTransition(
                    turns: Tween(begin: 0.9, end: 1.0).animate(animation),
                    child: child,
                  );
                },
                child: Icon(
                  favoritesMeals.contains(meal)
                      ? Icons.star
                      : Icons.star_border,
                  key: ValueKey(favoritesMeals.contains(meal)),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(16),
                // ),
                shadowColor: Colors.amber,
                elevation: 5,
                color: Colors.amber,
                clipBehavior: Clip.hardEdge,
                // padding: const EdgeInsets.all(16),
                child: Hero(
                  tag: meal.id,
                  child: Image.network(meal.imageUrl,
                      height: 300, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              Container(
                  color: const Color.fromARGB(54, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: const Text(
                    'INGRIDIENTS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 218, 225, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                color: const Color.fromARGB(54, 0, 0, 0),
                padding: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                child: Column(
                  children: [
                    for (final ingredient in meal.ingredients)
                      Text(
                        ingredient,
                        // textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  color: const Color.fromARGB(54, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: const Text(
                    'STEPS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 218, 225, 0),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                color: const Color.fromARGB(54, 0, 0, 0),
                // padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                padding: const EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (final step in meal.steps)
                      Text(
                        step,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 15),
                      )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
