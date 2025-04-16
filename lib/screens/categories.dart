import 'package:flutter/material.dart';
import 'package:flutter_meals_app/data/dummy_data.dart';
import 'package:flutter_meals_app/models/category.dart';
import 'package:flutter_meals_app/models/meal.dart';
import 'package:flutter_meals_app/screens/filters.dart';
import 'package:flutter_meals_app/screens/meals.dart';
import 'package:flutter_meals_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavourites,
    required this.filters,
  });

  final void Function(Meal meal) onToggleFavourites;
  final Map<Filter, bool> filters;

  void _selectCategory(BuildContext context, Category category) {
    final mealsData =
        dummyMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();

    final filteredMeals =
        mealsData.where((meal) {
          if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (filters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }
          return true;
        }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,
              onToggleFavourites: onToggleFavourites,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children:
          availableCategories
              .map(
                (category) => CategoryItem(
                  category: category,
                  onSelectCategory: () {
                    _selectCategory(context, category);
                  },
                ),
              )
              .toList(),
    );
  }
}
