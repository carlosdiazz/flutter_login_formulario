import 'package:flutter/material.dart';
import 'package:flutter_formulario/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_formulario/router/app_router.dart';
import 'package:flutter_formulario/services/services.dart';
import 'package:flutter_formulario/widgets/widgests.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          child: ProductCard(),
          onTap: () =>
              Navigator.pushNamed(context, AppRoute.productScreenRoute),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AppRoute.loginScreenRoute);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AppRoute.loginScreenRoute);
            },
            child: const Icon(Icons.arrow_back),
          )
        ],
      ),
    );
  }
}
