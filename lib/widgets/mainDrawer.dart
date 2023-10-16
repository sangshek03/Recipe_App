import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String indentifer) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
            ])),
            child: Row(
              children: [
                const Icon(
                  Icons.fastfood,
                  size: 40,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 28,
                      ),
                ),
              ],
            )),
        ListTile(
          leading: Icon(
            Icons.restaurant,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Meal',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 28),
          ),
          onTap: () {
            onSelectScreen('meal');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Filters',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 28),
          ),
          onTap: () {
            onSelectScreen('filters');
          },
        ),
      ]),
    );
  }
}
