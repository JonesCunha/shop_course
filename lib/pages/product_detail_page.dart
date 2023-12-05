// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'R\$ ${product.price}',
            style: TextStyle(
              fontSize: 26,
              backgroundColor: Colors.black12,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            product.description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
