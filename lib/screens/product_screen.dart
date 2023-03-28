import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_formulario/providers/product_form_provider.dart';
import 'package:flutter_formulario/services/product_service.dart';
import 'package:flutter_formulario/ui/input_decorations.dart';
import 'package:flutter_formulario/widgets/widgests.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
        create: (context) =>
            ProductFormProvider(product: productService.selectedProduct),
        child: _ProductScreenBody(productService: productService));
    //return _ProductScreenBody(productService: productService);
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
        //    .onDrag, //Al deslizar se oculta el teclado
        child: Column(children: [
          Stack(
            children: [
              ProductImage(url: productService.selectedProduct.picture),
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
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

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
              initialValue: product.name,
              onChanged: (value) => product.name = value,
              validator: (value) {
                if (value == null || value.length < 1) {
                  return 'El nombre es Obligatorio';
                }
              },
              decoration: InputDecorations.authInputDecoration(
                  hindText: "Nombre del Producto",
                  labelText: "Nombre:",
                  prefixIcon: Icons.production_quantity_limits_outlined),
            ),
            SizedBox(height: 30),
            TextFormField(
              initialValue: '${product.price}',
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (double.tryParse(value) == null) {
                  product.price = 0;
                } else {
                  product.price = double.parse(value);
                }
              },
              decoration: InputDecorations.authInputDecoration(
                  hindText: "\$100.0",
                  labelText: "Precio",
                  prefixIcon: Icons.production_quantity_limits_outlined),
            ),
            SizedBox(height: 30),
            SwitchListTile.adaptive(
              value: product.available,
              title: Text('Disponible'),
              activeColor: Colors.indigo,
              onChanged: (value) => productForm.updateAvailability(value),
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
