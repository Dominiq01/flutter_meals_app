import 'package:flutter/material.dart';
import 'package:flutter_meals_app/providers/filters_provider.dart';
import 'package:flutter_meals_app/widgets/filter_switch_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your filters')),
      body: Column(
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
