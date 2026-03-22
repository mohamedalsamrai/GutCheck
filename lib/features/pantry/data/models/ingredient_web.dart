import '../../../../core/constants/food_categories.dart';

class Ingredient {
  int id = 0;
  String name = '';
  String nameLower = '';
  FoodCategory category = FoodCategory.other;

  /// 'low' | 'moderate' | 'high'
  String fodmapLevel = 'moderate';

  /// true = came from seed JSON; false = user-created
  bool isSeeded = false;

  String? secondaryCategoryName;
  String? nameDE;
  String? photoPath;
  String? notes;
  DateTime createdAt = DateTime.now();

  /// Returns the display name for [languageCode] ('de' uses nameDE when set).
  String localizedName(String languageCode) {
    if (languageCode == 'de' && nameDE != null && nameDE!.isNotEmpty) {
      return nameDE!;
    }
    return name;
  }

  /// Resolved secondary category (null if none)
  FoodCategory? get secondaryCategory {
    if (secondaryCategoryName == null) return null;
    try {
      return FoodCategory.values.byName(secondaryCategoryName!);
    } catch (_) {
      return null;
    }
  }
}
