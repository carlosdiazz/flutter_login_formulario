import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_formulario/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-69aeb-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  bool isLoading = true;

  //TODO: hacer el fetch de producto
  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final temProduct = Product.fromJson(value);
      temProduct.id = key;
      products.add(temProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }
}