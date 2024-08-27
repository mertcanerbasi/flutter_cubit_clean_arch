import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit_clean_arch/features/data/models/character/character_model.dart';

import 'package:flutter_cubit_clean_arch/features/presentation/pages/characters_page/characters_page.dart';
import 'package:flutter_cubit_clean_arch/features/presentation/pages/detail_page/detail_page.dart';
// Import other pages as needed

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: CharacterRoute.page, initial: true),
        AutoRoute(page: DetailRoute.page),
      ];
}
