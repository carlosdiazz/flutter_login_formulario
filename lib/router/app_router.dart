import 'package:flutter/material.dart';
import 'package:flutter_formulario/screens/screens.dart';

class AppRoute {
  static const homeScreenRoute = 'homeScreenRoute';
  static const loginScreenRoute = 'loginScreenRoute';
  static const productScreenRoute = 'productScreenRoute';
  static const registerScreenRoute = 'registerScreenRoute';
  static const checkingScreen = 'checkingScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    homeScreenRoute: (context) => const HomeScreen(),
    loginScreenRoute: (context) => const LoginScreen(),
    productScreenRoute: (context) => const ProductScreen(),
    registerScreenRoute: (context) => const RegsiterScreen(),
    checkingScreen: (context) => const CheckAuthScreen()
  };
}
