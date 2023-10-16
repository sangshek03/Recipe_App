import 'package:flutter/material.dart';

enum Filter { vegan, vegetarian, glutenfree, lactosefree }

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;
  var _lactosefreeFilterSet = false;
  var _glutenfreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenfreeFilterSet = widget.currentFilters[Filter.glutenfree]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    _lactosefreeFilterSet = widget.currentFilters[Filter.lactosefree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.vegan: _veganFilterSet,
              Filter.glutenfree: _glutenfreeFilterSet,
              Filter.lactosefree: _lactosefreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
            });
            return false;
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _veganFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _veganFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only Include Vegan Meals',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _lactosefreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _lactosefreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Lactose Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only Include Lactose Free Meals',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _glutenfreeFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _glutenfreeFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Gluten Free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only Include Gluten Free Meals',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
              SwitchListTile(
                value: _vegetarianFilterSet,
                onChanged: (isChecked) {
                  setState(() {
                    _vegetarianFilterSet = isChecked;
                  });
                },
                title: Text(
                  'Vegetarian',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only Include Vegetarian Meals',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 22),
              ),
            ],
          ),
        ));
  }
}
