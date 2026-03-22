import 'package:flutter/material.dart';

import 'app_colors.dart';

enum FoodCategory {
  vegetable,
  fruit,
  grain,
  protein,
  dairy,
  legume,
  fat,
  herb,
  spice,
  beverage,
  other;

  String get displayName {
    switch (this) {
      case FoodCategory.vegetable:
        return 'Vegetable';
      case FoodCategory.fruit:
        return 'Fruit';
      case FoodCategory.grain:
        return 'Grain';
      case FoodCategory.protein:
        return 'Protein';
      case FoodCategory.dairy:
        return 'Dairy';
      case FoodCategory.legume:
        return 'Legume';
      case FoodCategory.fat:
        return 'Fat/Oil';
      case FoodCategory.herb:
        return 'Herb';
      case FoodCategory.spice:
        return 'Spice';
      case FoodCategory.beverage:
        return 'Beverage';
      case FoodCategory.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case FoodCategory.vegetable:
        return AppColors.vegetable;
      case FoodCategory.fruit:
        return AppColors.fruit;
      case FoodCategory.grain:
        return AppColors.grain;
      case FoodCategory.protein:
        return AppColors.protein;
      case FoodCategory.dairy:
        return AppColors.dairy;
      case FoodCategory.legume:
        return AppColors.legume;
      case FoodCategory.fat:
        return AppColors.fat;
      case FoodCategory.herb:
        return AppColors.herb;
      case FoodCategory.spice:
        return AppColors.spice;
      case FoodCategory.beverage:
        return AppColors.beverage;
      case FoodCategory.other:
        return AppColors.other;
    }
  }

  IconData get icon {
    switch (this) {
      case FoodCategory.vegetable:
        return Icons.eco;
      case FoodCategory.fruit:
        return Icons.apple;
      case FoodCategory.grain:
        return Icons.grain;
      case FoodCategory.protein:
        return Icons.set_meal;
      case FoodCategory.dairy:
        return Icons.egg_alt_rounded;
      case FoodCategory.legume:
        return Icons.spa;
      case FoodCategory.fat:
        return Icons.water_drop;
      case FoodCategory.herb:
        return Icons.spa_outlined;
      case FoodCategory.spice:
        return Icons.whatshot_rounded;
      case FoodCategory.beverage:
        return Icons.local_cafe;
      case FoodCategory.other:
        return Icons.category;
    }
  }
}
