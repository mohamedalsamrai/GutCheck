class WellnessEntry {
  int id = 0;

  /// When symptoms were recorded
  DateTime recordedAt = DateTime.now();

  /// Overall gut comfort. 1 = very uncomfortable, 10 = perfect.
  int gutPeace = 10;

  /// Heartburn intensity. 1 = none, 10 = severe. Defaults to 1 for old records.
  int heartburn = 1;

  /// Whether the user experienced diarrhea. Defaults to false for old records.
  bool diarrhea = false;

  /// Composite 0–100 score stored for fast querying.
  double wellnessScore = 100.0;

  /// IDs of MealEntry records the user linked to these symptoms.
  List<int> linkedMealIds = [];

  String? notes;

  /// true = inserted by SampleDataService
  bool isSample = false;

  DateTime createdAt = DateTime.now();
}
