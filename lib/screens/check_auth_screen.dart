import 'package:flutter/material.dart';
import 'package:flutter_formulario/router/app_router.dart';
import 'package:flutter_formulario/screens/login_screen.dart';
import 'package:flutter_formulario/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_formulario/services/services.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('data');
          if (snapshot.data == '') {
            Future.microtask(() {
              //es la instruccion que se va a ejcutar cuando este Builder termine
              //Navigator.of(context).pushReplacementNamed(AppRoute.loginScreenRoute);
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LoginScreen(),
                      transitionDuration: Duration(seconds: 0)));
            });
          } else {
            Future.microtask(() {
              //es la instruccion que se va a ejcutar cuando este Builder termine
              //Navigator.of(context).pushReplacementNamed(AppRoute.loginScreenRoute);
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          HomeScreen(),
                      transitionDuration: Duration(seconds: 0)));
            });
          }

          return const Center();
        },
      )),
    );
  }
}
