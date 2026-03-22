import 'package:gutcheck/l10n/app_localizations.dart';

import '../constants/food_categories.dart';
import '../utils/date_utils.dart';

extension FoodCategoryL10n on FoodCategory {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case FoodCategory.vegetable:
        return l10n.categoryVegetable;
      case FoodCategory.fruit:
        return l10n.categoryFruit;
      case FoodCategory.grain:
        return l10n.categoryGrain;
      case FoodCategory.protein:
        return l10n.categoryProtein;
      case FoodCategory.dairy:
        return l10n.categoryDairy;
      case FoodCategory.legume:
        return l10n.categoryLegume;
      case FoodCategory.fat:
        return l10n.categoryFat;
      case FoodCategory.herb:
        return l10n.categoryHerb;
      case FoodCategory.spice:
        return l10n.categorySpice;
      case FoodCategory.beverage:
        return l10n.categoryBeverage;
      case FoodCategory.other:
        return l10n.categoryOther;
    }
  }
}

extension TimeFilterL10n on TimeFilter {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case TimeFilter.day:
        return l10n.timeFilterDay;
      case TimeFilter.week:
        return l10n.timeFilterWeek;
      case TimeFilter.month:
        return l10n.timeFilterMonth;
      case TimeFilter.year:
        return l10n.timeFilterYear;
    }
  }
}

String localizedMealLabel(String? label, AppLocalizations l10n) {
  switch (label) {
    case 'Breakfast':
      return l10n.mealBreakfast;
    case 'Lunch':
      return l10n.mealLunch;
    case 'Dinner':
      return l10n.mealDinner;
    case 'Snack':
      return l10n.mealSnack;
    default:
      return label ?? l10n.mealFallbackLabel;
  }
}
