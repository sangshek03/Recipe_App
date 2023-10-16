import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(
      {super.key, required this.meal, required this.togglefavorites});

  final Meal meal;
  final void Function(Meal meal) togglefavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  togglefavorites(meal);
                },
                icon: const Icon(Icons.star)),
          ],
          title: Text(meal.title),
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
                child: Image.network(meal.imageUrl,
                    height: 300, width: double.infinity, fit: BoxFit.cover),
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
