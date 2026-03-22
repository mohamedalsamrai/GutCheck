import 'package:gutcheck/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class GutDateUtils {
  GutDateUtils._();

  static final _dateFormat = DateFormat('MMM d, yyyy');
  static final _timeFormat = DateFormat('h:mm a');
  static final _dayFormat = DateFormat('EEE, MMM d');
  static final _monthFormat = DateFormat('MMMM yyyy');

  static String formatDate(DateTime dt) => _dateFormat.format(dt);
  static String formatTime(DateTime dt) => _timeFormat.format(dt);
  static String formatDay(DateTime dt) => _dayFormat.format(dt);
  static String formatMonth(DateTime dt) => _monthFormat.format(dt);

  static DateTime startOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day);

  static DateTime endOfDay(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day, 23, 59, 59, 999);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static List<DateTime> daysInMonth(DateTime month) {
    final last = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      last.day,
      (i) => DateTime(month.year, month.month, i + 1),
    );
  }

  static String timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDate(dt);
  }

  static String timeAgoLocalized(DateTime dt, AppLocalizations l10n) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return l10n.timeJustNow;
    if (diff.inMinutes < 60) return l10n.timeMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l10n.timeHoursAgo(diff.inHours);
    if (diff.inDays < 7) return l10n.timeDaysAgo(diff.inDays);
    return formatDate(dt);
  }
}

class DateRange {
  final DateTime start;
  final DateTime end;
  const DateRange({required this.start, required this.end});
}

enum TimeFilter {
  day,
  week,
  month,
  year;

  String get label {
    switch (this) {
      case TimeFilter.day:
        return 'Day';
      case TimeFilter.week:
        return 'Week';
      case TimeFilter.month:
        return 'Month';
      case TimeFilter.year:
        return 'Year';
    }
  }

  DateRange toDateRange() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    switch (this) {
      case TimeFilter.day:
        return DateRange(start: today, end: tomorrow);
      case TimeFilter.week:
        return DateRange(
          start: today.subtract(const Duration(days: 7)),
          end: tomorrow,
        );
      case TimeFilter.month:
        return DateRange(
          start: today.subtract(const Duration(days: 30)),
          end: tomorrow,
        );
      case TimeFilter.year:
        return DateRange(
          start: today.subtract(const Duration(days: 365)),
          end: tomorrow,
        );
    }
  }
}
