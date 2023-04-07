import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_formulario/router/app_router.dart';
import 'package:flutter_formulario/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsService(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.checkingScreen,
      routes: AppRoute.routes,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.indigo, elevation: 0),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo)),
    );
  }
}
