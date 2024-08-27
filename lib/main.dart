import 'package:flutter/material.dart';
import 'package:flutter_cubit_clean_arch/core/di/dependency_injector.dart';
import 'package:flutter_cubit_clean_arch/routes/app_router.dart';

void main() async {
  await setupDI("dev");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
