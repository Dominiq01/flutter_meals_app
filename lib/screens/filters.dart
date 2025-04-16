import 'package:flutter/material.dart';
import 'package:flutter_meals_app/widgets/filter_switch_tile.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});
  final Map<Filter, bool> filters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet = widget.filters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.filters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.filters[Filter.vegetarian]!;
    _veganFilterSet = widget.filters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your filters')),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            FilterSwitchTile(
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              currentValue: _glutenFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchTile(
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              currentValue: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchTile(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              currentValue: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
            ),
            FilterSwitchTile(
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              currentValue: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
