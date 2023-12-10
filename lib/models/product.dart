// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_curse/constants/urls.dart';

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

  Future<void> toggleFavorite(String token, String userID) async {
    // ignore: prefer_const_declarations

    final response = await http.put(
      Uri.parse('${Constants.BASE_URL_FAVORITES}/$userID/$id.json?auth=$token'),
      body: jsonEncode(!isFavorite),
    );

    if (response.statusCode < 400) {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
