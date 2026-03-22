import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/ui/screens/home_screen.dart';
import '../../features/insights/ui/screens/insights_screen.dart';
import '../../features/meal_log/ui/screens/meal_log_screen.dart';
import '../../features/pantry/ui/screens/add_custom_food_screen.dart';
import '../../features/pantry/ui/screens/pantry_screen.dart';
import '../../features/wellness/ui/screens/wellness_check_screen.dart';
import '../../features/wellness/ui/screens/wellness_history_screen.dart';
import 'app_shell.dart';
import 'settings_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      if (state.uri.path == '/' || state.uri.path.isEmpty) return '/home';
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/pantry',
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: PantryScreen()),
            routes: [
              GoRoute(
                path: 'add-food',
                builder: (c, s) => const AddCustomFoodScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/log',
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: MealLogScreen()),
          ),
          GoRoute(
            path: '/wellness',
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: WellnessCheckScreen()),
            routes: [
              GoRoute(
                path: 'history',
                builder: (c, s) => const WellnessHistoryScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/insights',
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: InsightsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (c, s) => const SettingsScreen(),
      ),
    ],
  );
});
