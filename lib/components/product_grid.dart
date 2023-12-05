import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/components/product_grid_item.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key, required this.showFavoriteOnly});

  final bool showFavoriteOnly;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<Product> products =
        showFavoriteOnly ? provider.favoriteItems : provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductGridItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
