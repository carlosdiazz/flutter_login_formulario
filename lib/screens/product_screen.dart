import 'package:flutter/material.dart';
import 'package:flutter_formulario/widgets/widgests.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [ProductImage()],
          )
        ]),
      ),
    );
  }
}
