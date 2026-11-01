import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';




import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/view/pages/auth_page.dart';
import '../../features/depts/view/pages/debts_page.dart';

import '../../features/goals/view/pages/goals_page.dart';
import '../../features/home/view/pages/home_page.dart';
import '../../features/income/view/pages/income_page.dart';
import 'app_routes.dart';


final routerProvider = Provider<GoRouter>((ref) {
  final authRepo = ref.read(authRepoProvider);
  return GoRouter(
    initialLocation: AppRoutes.auth,
    redirect: (context, state) {
      final isLoggedIn = authRepo.currentUser != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.auth;
      if (!isLoggedIn) {
        return isAuthRoute ? null : AppRoutes.auth;
      }
      if (isAuthRoute) return AppRoutes.home;
      return null;
    },

    routes: [
     GoRoute(path: AppRoutes.auth, builder: (context, state) => AuthPage()),
      GoRoute(path: AppRoutes.home, builder: (context, state) => HomePage()),
      GoRoute(path: AppRoutes.goals, builder: (context, state) => GoalsPage()),
       GoRoute(path: AppRoutes.depts, builder: (context, state) =>  DebtsPage()),
      GoRoute(path: AppRoutes.income, builder: (context, state) =>  IncomePage()),





    ],
  );
});
