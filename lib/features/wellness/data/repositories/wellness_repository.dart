import 'package:isar/isar.dart';

import '../models/wellness_entry.dart';

class WellnessRepository {
  final Isar _isar;
  WellnessRepository(this._isar);

  Future<List<WellnessEntry>> inRange({
    required DateTime from,
    required DateTime to,
  }) {
    return _isar.wellnessEntrys
        .filter()
        .recordedAtBetween(from, to)
        .sortByRecordedAt()
        .findAll();
  }

  Future<List<WellnessEntry>> forDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return _isar.wellnessEntrys
        .filter()
        .recordedAtBetween(start, end)
        .sortByRecordedAtDesc()
        .findAll();
  }

  Future<void> save(WellnessEntry entry) async {
    await _isar.writeTxn(() => _isar.wellnessEntrys.put(entry));
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.wellnessEntrys.delete(id));
  }

  Future<List<WellnessEntry>> all() =>
      _isar.wellnessEntrys.where().sortByRecordedAt().findAll();

  Future<void> deleteAll() async {
    await _isar.writeTxn(() => _isar.wellnessEntrys.where().deleteAll());
  }
}
