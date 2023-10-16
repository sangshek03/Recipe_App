import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.lable});

  final IconData icon;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: Colors.white,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          lable,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        )
      ],
    );
  }
}
