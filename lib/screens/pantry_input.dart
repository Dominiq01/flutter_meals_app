import 'package:flutter/material.dart';
import 'package:flutter_meals_app/screens/matching_meals.dart';

class PantryInputScreen extends StatefulWidget {
  const PantryInputScreen({super.key});

  @override
  State<PantryInputScreen> createState() => _PantryInputScreenState();
}

class _PantryInputScreenState extends State<PantryInputScreen> {
  final _ingredientController = TextEditingController();
  final List<String> _ingredients = [];

  void _addIngredient() {
    final input = _ingredientController.text.trim();
    if (input.isNotEmpty && !_ingredients.contains(input)) {
      setState(() {
        _ingredients.add(input);
      });
      _ingredientController.clear();
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
    });
  }

  void _searchMeals() {
    if (_ingredients.isNotEmpty) {
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (ctx) => MatchingMealsScreen(
      ingredients: _ingredients,
    ),
  ),
);

    }
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Pantry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Enter ingredient',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addIngredient,
                ),
              ),
              onSubmitted: (_) => _addIngredient(),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              children: _ingredients
                  .map(
                    (ingredient) => Chip(
                      label: Text(ingredient),
                      onDeleted: () => _removeIngredient(ingredient),
                      backgroundColor: colorScheme.secondaryContainer,
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _searchMeals,
              icon: const Icon(Icons.search),
              label: const Text('Find Meals'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
