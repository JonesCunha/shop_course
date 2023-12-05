import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(Product product) async {
    final _baseUrl =
        'https://shop-jp-11ae4-default-rtdb.firebaseio.com/products';

    isFavorite = !isFavorite;
    notifyListeners();

    await http.patch(Uri.parse('$_baseUrl/${product.id}.json'),
        body: jsonEncode({'isFavorite': isFavorite}));
  }
}
