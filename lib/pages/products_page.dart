import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/components/app_drawer.dart';
import 'package:shop_curse/components/product_item.dart';
import 'package:shop_curse/models/product_list.dart';
import 'package:shop_curse/utils/app_routes.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.itemCount,
            itemBuilder: (context, index) => Column(
              children: [
                ProductItem(product: productList.items[index]),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
