import 'package:flutter/material.dart';
import 'package:flutter_formulario/router/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.homeScreenRoute,
      routes: AppRoute.routes,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.indigo, elevation: 0),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.indigo)),
    );
  }
}
