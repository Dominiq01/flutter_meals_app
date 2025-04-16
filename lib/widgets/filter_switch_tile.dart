import 'package:flutter/material.dart';

class FilterSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool currentValue;
  final void Function(bool) onChanged;

  const FilterSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: currentValue,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
