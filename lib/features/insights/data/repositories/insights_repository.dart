import '../../../wellness/data/models/wellness_entry.dart';

class InsightsRepository {
  InsightsRepository._();

  /// Aggregate wellness entries into a daily average map.
  static Map<DateTime, double> aggregateByDay(
      List<WellnessEntry> entries) {
    final Map<DateTime, List<double>> groups = {};

    for (final e in entries) {
      final day = DateTime(
          e.recordedAt.year, e.recordedAt.month, e.recordedAt.day);
      groups.putIfAbsent(day, () => []).add(e.wellnessScore);
    }

    return groups.map((day, scores) {
      final avg = scores.reduce((a, b) => a + b) / scores.length;
      return MapEntry(day, avg);
    });
  }
}
