// ignore_for_file: no_leading_underscores_for_local_identifiers

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

  // Adicionado cometarios

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token) async {
    // ignore: prefer_const_declarations
    final _baseUrl =
        'https://shop-jp-11ae4-default-rtdb.firebaseio.com/products';

    final response = await http.patch(
        Uri.parse('$_baseUrl/$id.json?auth=$token'),
        body: jsonEncode({'isFavorite': isFavorite}));

    if (response.statusCode < 400) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
