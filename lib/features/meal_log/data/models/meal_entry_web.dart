import 'meal_ingredient.dart';

class MealEntry {
  int id = 0;

  /// When the meal was consumed (user-editable, defaults to now)
  DateTime consumedAt = DateTime.now();

  /// "Breakfast", "Lunch", "Dinner", "Snack"
  String? mealLabel;

  List<MealIngredient> ingredients = [];

  String? photoPath;
  String? notes;

  /// true = inserted by SampleDataService
  bool isSample = false;

  DateTime createdAt = DateTime.now();
}
