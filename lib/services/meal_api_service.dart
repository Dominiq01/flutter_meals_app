import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_meals_app/models/meal.dart';

class MealApiService {
  static Future<Meal?> fetchRandomMeal() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final mealJson = data['meals'][0];

      return Meal(
        id: mealJson['idMeal'],
        title: mealJson['strMeal'],
        imageUrl: mealJson['strMealThumb'],
        ingredients: _extractIngredients(mealJson),
        steps: [mealJson['strInstructions']],
        duration: 30,
        complexity: Complexity.simple,
        affordability: Affordability.affordable,
        categories: ['c1'],
        isGlutenFree: false,
        isLactoseFree: false,
        isVegan: false,
        isVegetarian: false,
      );
    }

    return null;
  }

  static List<String> _extractIngredients(Map<String, dynamic> json) {
    final ingredients = <String>[];
    for (var i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient);
      }
    }
    return ingredients;
  }
}
