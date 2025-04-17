import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/widgets/meals_list.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return MealsList(meals: meals);
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: MealsList(meals: meals),
    );
  }
}
