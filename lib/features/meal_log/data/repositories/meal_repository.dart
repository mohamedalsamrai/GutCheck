import 'package:isar/isar.dart';

import '../models/meal_entry.dart';

class MealRepository {
  final Isar _isar;
  MealRepository(this._isar);

  Future<List<MealEntry>> forDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return _isar.mealEntrys
        .filter()
        .consumedAtBetween(start, end)
        .sortByConsumedAtDesc()
        .findAll();
  }

  Future<List<MealEntry>> inRange({
    required DateTime from,
    required DateTime to,
  }) {
    return _isar.mealEntrys
        .filter()
        .consumedAtBetween(from, to)
        .sortByConsumedAt()
        .findAll();
  }

  Future<MealEntry?> findById(int id) => _isar.mealEntrys.get(id);

  Future<void> save(MealEntry entry) async {
    await _isar.writeTxn(() => _isar.mealEntrys.put(entry));
  }

  Future<void> delete(int id) async {
    await _isar.writeTxn(() => _isar.mealEntrys.delete(id));
  }

  Future<List<MealEntry>> all() =>
      _isar.mealEntrys.where().sortByConsumedAt().findAll();

  Future<void> deleteAll() async {
    await _isar.writeTxn(() => _isar.mealEntrys.where().deleteAll());
  }
}
