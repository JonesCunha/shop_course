import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_curse/models/product.dart';

class ProductList with ChangeNotifier {
  final String _token;
  // ignore: prefer_final_fields
  List<Product> _items = [];
  //bool _showFavoriteOnly = false;

  ProductList(this._token, this._items);

  final baseUrl = 'https://shop-jp-11ae4-default-rtdb.firebaseio.com/products';
  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((element) => element.isFavorite).toList();

  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$baseUrl.json?auth=$_token'));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((key, value) {
      _items.add(
        Product(
          id: key,
          name: value['name'],
          description: value['description'],
          price: double.parse(value['price'].toString()),
          imageUrl: value['imageUrl'],
        ),
      );
      notifyListeners();
    });
  }

  Future<void> addProduct(Product product) {
    var future = http.post(Uri.parse('$baseUrl.json?auth=$_token'),
        body: jsonEncode({
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        }));
    return future.then((value) {
      _items.add(Product(
        id: jsonDecode(value.body)['name'],
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ));
      notifyListeners();
    });
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    if (hasId) {
      return updateProduct(newProduct);
    } else {
      return addProduct(newProduct);
    }
  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$baseUrl/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.name,
            "id": product.id,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> removeItem(Product product) async {
    await http.delete(Uri.parse('$baseUrl/${product.id}.json?auth=$_token'));
    _items.remove(product);
    notifyListeners();
  }
}
