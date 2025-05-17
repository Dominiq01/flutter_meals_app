import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/widgets/filter_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Your Filters',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilterSwitchTile(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            currentValue: filters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
          ),
          const SizedBox(height: 12),
          FilterSwitchTile(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            currentValue: filters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
          ),
          const SizedBox(height: 12),
          FilterSwitchTile(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            currentValue: filters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
          ),
          const SizedBox(height: 12),
          FilterSwitchTile(
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            currentValue: filters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
          ),
        ],
      ),
    );
  }
}
