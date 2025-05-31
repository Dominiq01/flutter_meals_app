import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.fastfood, size: 48, color: colorScheme.primary),
                const SizedBox(width: 16),
                Text(
                  'Cooking Up!',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.restaurant,
                  color: colorScheme.primary,
                  size: 26,
                ),
                title: Text(
                  'Meals',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: colorScheme.primary,
                  ),
                ),
                onTap: () => onSelectScreen('meals'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: colorScheme.primary,
                  size: 26,
                ),
                title: Text(
                  'Filters',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: colorScheme.primary,
                  ),
                ),
                onTap: () => onSelectScreen('filters'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.shuffle,
                  color: colorScheme.primary,
                  size: 26,
                ),
                title: Text(
                  'Surprise Me',
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 20,
                    color: colorScheme.primary,
                  ),
                ),
                onTap: () => onSelectScreen('random'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.kitchen,
                  color: Theme.of(context).colorScheme.primary,
                  size: 26,
                ),
                title: Text(
                  'Smart Pantry',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 20, color: colorScheme.primary),
                ),
                onTap: () => onSelectScreen('smart-pantry'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
