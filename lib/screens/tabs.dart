import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/favourites_provider.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/screens/categories.dart';
import 'package:flutter_meals_app/screens/filters.dart';
import 'package:flutter_meals_app/screens/meal_details.dart';
import 'package:flutter_meals_app/screens/meals.dart';
import 'package:flutter_meals_app/services/meal_api_service.dart';
import 'package:flutter_meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kDefaultFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
    if (identifier == 'meals') {
      setState(() {
        _selectedPageIndex = 0;
      });
    }

    if (identifier == 'smart-pantry') {
      Navigator.of(context).pushNamed('/smart-pantry');
    }
    
    if (identifier == 'random') {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (ctx) => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
      );

      final randomMeal = await MealApiService.fetchRandomMeal();

      if (!context.mounted) return;
      Navigator.of(context).pop();

      if (randomMeal != null) {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    MealDetailsScreen(meal: randomMeal),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              final scale = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
              );

              return ScaleTransition(scale: scale, child: child);
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteMeals = ref.watch(favouritesProvider);

    final List<Widget> pages = [
      const CategoriesScreen(),
      MealsScreen(meals: favouriteMeals),
    ];

    final List<String> titles = ['Categories', 'Favourites'];

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primaryContainer,
                colorScheme.primaryContainer.withValues(alpha: .8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            iconTheme: IconThemeData(color: colorScheme.primary),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              titles[_selectedPageIndex],
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        selectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
        ],
        type: BottomNavigationBarType.fixed,
        elevation: 4,
      ),
    );
  }
}
