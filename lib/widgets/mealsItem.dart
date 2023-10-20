import 'package:flutter/material.dart';
import 'package:meals_app/screens/mealDetailScreen.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/models/meal.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.meal});

  final Meal meal;

  String get mealComplexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get mealAffordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  void onSelectMeal(BuildContext context, Meal selectedMeal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(meal: selectedMeal,)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
          onTap: () {
            onSelectMeal(context, meal);
          },
          child: Stack(
            children: [
              Hero(
                tag: meal.id,
                child: FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit
                      .cover, // if image is large then it automatically cuts off
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    color: const Color.fromARGB(103, 19, 19, 19),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          meal.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow
                              .ellipsis, // if text is overflow then ...
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            // fontFamily: AutofillHints.familyName,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MealItemTrait(
                                icon: Icons.timer,
                                lable: '${meal.duration} min'),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                icon: Icons.work, lable: mealComplexityText),
                            const SizedBox(
                              width: 12,
                            ),
                            MealItemTrait(
                                icon: Icons.currency_rupee_outlined,
                                lable: mealAffordabilityText)
                          ],
                        )
                      ],
                    )),
              ),
            ],
          )),
    );
  }
}
