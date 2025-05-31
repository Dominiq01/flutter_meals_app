import 'package:flutter/material.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/services/meal_api_service.dart';
import 'package:flutter_meals_app/widgets/meals_list.dart';

class MatchingMealsScreen extends StatelessWidget {
  const MatchingMealsScreen({super.key, required this.ingredients});

  final List<String> ingredients;

  Future<List<Meal>> _loadMeals() {
    return MealApiService.fetchMealsByIngredients(ingredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matching Meals'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Meal>>(
        future: _loadMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'An error occurred: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final meals = snapshot.data ?? [];

          if (meals.isEmpty) {
            return const Center(child: Text('No meals found for those ingredients.'));
          }

          return MealsList(meals: meals);
        },
      ),
    );
  }
}
