enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      title: json['strMeal'] ?? 'Unknown',
      imageUrl: json['strMealThumb'] ?? '',
      ingredients:
          List.generate(20, (index) {
            final ingredient = json['strIngredient${index + 1}'];
            final measure = json['strMeasure${index + 1}'];
            if (ingredient != null &&
                ingredient.toString().isNotEmpty &&
                ingredient.toString() != 'null') {
              return measure != null && measure.toString().isNotEmpty
                  ? '$ingredient - $measure'
                  : ingredient;
            }
            return null;
          }).whereType<String>().toList(),
      steps:
          (json['strInstructions'] as String?)
              ?.split('\n')
              .where((line) => line.trim().isNotEmpty)
              .toList() ??
          [],
      duration: 20,
      complexity: Complexity.simple,
      affordability: Affordability.affordable,
      categories: [],
      isGlutenFree: false,
      isLactoseFree: false,
      isVegan: false,
      isVegetarian: false,
    );
  }
}
