import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'db_factory.dart';

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final db = await createDatabase();
  ref.keepAlive();
  return db;
});
