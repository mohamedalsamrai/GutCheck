import 'package:flutter/material.dart';

import '../../data/models/meal_ingredient.dart';

class MealIngredientChip extends StatelessWidget {
  final MealIngredient item;
  final VoidCallback? onDelete;

  const MealIngredientChip({
    super.key,
    required this.item,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        item.quantity != null
            ? '${item.ingredientName} (${item.quantity})'
            : item.ingredientName,
        style: const TextStyle(fontSize: 12),
      ),
      onDeleted: onDelete,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
