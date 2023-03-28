import 'package:flutter/material.dart';
import 'package:flutter_formulario/ui/input_decorations.dart';
import 'package:flutter_formulario/widgets/widgests.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(),
              Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 40,
                        color: Colors.white,
                      ))),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                      onPressed: () {
                        //TODO galeria
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      )))
            ],
          ),
          _ProductForm(),
          SizedBox(
            height: 200,
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO guardar producto
        },
        child: Icon(Icons.save_alt),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        //height: 300,
        decoration: _buildBoxDecoration(),
        child: Form(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hindText: "Nombre del Producto",
                  labelText: "Nombre:",
                  prefixIcon: Icons.production_quantity_limits_outlined),
            ),
            SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                  hindText: "\$100.0",
                  labelText: "Precio",
                  prefixIcon: Icons.production_quantity_limits_outlined),
            ),
            SizedBox(height: 30),
            SwitchListTile.adaptive(
              value: true,
              title: Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: (value) {
                //TODO pendiente
              },
            ),
            SizedBox(height: 30),
          ],
        )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
