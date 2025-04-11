import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/meal_details.dart';
import 'package:flutter_meals_app/widgets/meal_item.dart';

class MealsList extends StatelessWidget {
  const MealsList({
    super.key,
    required this.meals,
    required this.onToggleFavourites,
  });

  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavourites;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailsScreen(
              meal: meal,
              onToggleFavourites: onToggleFavourites,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder:
          (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: () {
              _selectMeal(context, meals[index]);
            },
          ),
    );
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing here...',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try selecting different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    }
    return content;
  }
}
