import '../../../core/constants/food_categories.dart';
import 'correlation_engine.dart';

class ImpactScore {
  final int ingredientId;
  final String ingredientName;
  final FoodCategory category;

  /// Pearson r: −1.0 (always bad) to +1.0 (always good). 0 = no correlation.
  final double pearsonR;

  /// The zone.from hour (0, 4, or 12) of the zone that produces the strongest |r|.
  final int bestLagHours;

  /// Number of data points used for this correlation.
  final int sampleCount;

  /// 0–1: min(1.0, sampleCount / 20). Discounts sparse data.
  final double confidenceLevel;

  /// Pearson r at each time zone (key = zone.from hours: 0, 4, 12).
  final Map<int, double> pearsonByLag;

  const ImpactScore({
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.pearsonR,
    required this.bestLagHours,
    required this.sampleCount,
    required this.confidenceLevel,
    this.pearsonByLag = const {},
  });

  /// Adjusted score used for ranking: |r| * confidence
  double get rankScore => pearsonR.abs() * confidenceLevel;

  /// Percentage representation of |pearsonR| * 100
  int get correlationPercent => (pearsonR.abs() * 100).round();

  /// true if the food is associated with WORSE wellness
  bool get isHarmful => pearsonR < 0;

  /// The time zone that produced the best correlation.
  ({int from, int to, String label, String shortLabel}) get bestZone {
    return CorrelationEngine.timeZones.firstWhere(
      (z) => z.from == bestLagHours,
      orElse: () => CorrelationEngine.timeZones.first,
    );
  }

  String get summaryText {
    if (sampleCount < 3) return 'Not enough data yet';
    final pct = correlationPercent;
    final direction = isHarmful ? 'drop' : 'improvement';
    final zone = bestZone;
    return '$pct% correlation with wellness $direction in the ${zone.label} window (${zone.shortLabel} after eating)';
  }
}
