import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gutcheck/l10n/app_localizations.dart';
import '../../../../core/database/app_database_provider.dart';
import '../../../../core/l10n/l10n_extensions.dart';
import '../../../../core/utils/date_utils.dart';
import '../../providers/wellness_providers.dart';

class LinkedMealSelector extends ConsumerWidget {
  const LinkedMealSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final linkedIds = ref.watch(
        wellnessDraftProvider.select((s) => s.linkedMealIds));

    return FutureBuilder(
      future: _loadRecentMeals(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        final meals = snapshot.data!;
        if (meals.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.linkedMealNoRecent,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          );
        }

        return SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemCount: meals.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (ctx, i) {
              final meal = meals[i];
              final isLinked = linkedIds.contains(meal.id);
              return GestureDetector(
                onTap: () => ref
                    .read(wellnessDraftProvider.notifier)
                    .toggleMealLink(meal.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isLinked
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isLinked
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedMealLabel(meal.mealLabel, l10n),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: isLinked
                              ? Theme.of(context).colorScheme.onPrimaryContainer
                              : null,
                        ),
                      ),
                      Text(
                        GutDateUtils.timeAgoLocalized(meal.consumedAt, l10n),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                        ),
                      ),
                      if (meal.ingredients.isNotEmpty)
                        Text(
                          meal.ingredients.take(2).map((i) => i.ingredientName).join(', '),
                          style: const TextStyle(fontSize: 10, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<dynamic> _loadRecentMeals(WidgetRef ref) async {
    final db = await ref.read(appDatabaseProvider.future);
    final from = DateTime.now().subtract(const Duration(hours: 12));
    return db.mealsInRange(from: from, to: DateTime.now());
  }
}
