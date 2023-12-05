import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_curse/models/cart_itens.dart';
import 'package:shop_curse/models/product.dart';
import 'package:shop_curse/models/cart_abs.dart';

class Cart extends ICart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  @override
  int get itensCount {
    return _items.length;
  }

  @override
  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  @override
  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          name: existingItem.name,
          quantity: existingItem.quantity - 1,
          price: existingItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => CartItem(
          id: value.id,
          productId: value.productId,
          name: value.name,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  double get totalAmout {
    double total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
