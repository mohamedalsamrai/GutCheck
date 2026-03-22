import 'app_database.dart';
import 'isar_app_database.dart' if (dart.library.html) 'hive_app_database.dart';

export 'app_database.dart';

Future<AppDatabase> createDatabase() => createAppDatabase();
