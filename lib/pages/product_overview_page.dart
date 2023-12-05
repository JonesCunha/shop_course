// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/components/app_drawer.dart';
import 'package:shop_curse/models/product_list.dart';
import 'package:shop_curse/utils/app_routes.dart';
import '../components/badgee.dart';
import '../components/product_grid.dart';
import '../models/cart.dart';

enum FilterOptions { favorite, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _isLoading = true;
    // Provider.of<ProductList>(context, listen: false)
    // .loadProducts()
    // .then((value) {
    setState(() {
      _isLoading = false;
    });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<ProductList>(context).loadProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ProductList>(context, listen: false).loadProducts();
              },
              icon: Icon(Icons.ac_unit)),
          PopupMenuButton(
              icon: _showFavoriteOnly
                  ? Icon(
                      Icons.favorite_sharp,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_outline),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {},
                      value: FilterOptions.favorite,
                      child: Text('Somente Favoritos'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.all,
                      child: Text('Todos'),
                    ),
                  ],
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorite) {
                    _showFavoriteOnly = true;
                  } else {
                    _showFavoriteOnly = false;
                  }
                });
              }),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART_PAGE);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            builder: (context, cart, child) =>
                Badgee(value: cart.itensCount.toString(), child: child!),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showFavoriteOnly: _showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
