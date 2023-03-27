import 'package:flutter/material.dart';
import 'package:flutter_formulario/screens/screens.dart';

class AppRoute {
  static const homeScreenRoute = 'homeScreenRoute';
  static const loginScreenRoute = 'loginScreenRoute';

  static Map<String, Widget Function(BuildContext)> routes = {
    homeScreenRoute: (context) => const HomeScreen(),
    loginScreenRoute: (context) => const LoginScreen()
  };
}
