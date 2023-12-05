import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/pages/cart_page.dart';
import 'package:shop_curse/pages/orders_page.dart';
import 'package:shop_curse/pages/product_detail_page.dart';
import 'package:shop_curse/pages/product_form_page.dart';
import 'package:shop_curse/pages/product_overview_page.dart';
import 'package:shop_curse/pages/products_page.dart';
import 'package:shop_curse/theme.dart';

import 'models/cart.dart';
import 'models/order_list.dart';
import 'models/product_list.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //modelo de mult providers.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        //theme criado em um arquivo separado.
        theme: themeData(),
        // home: const ProductOverviewPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.PRODUCT_DETAIL_PAGE: (context) => const ProductDetailPage(),
          AppRoutes.CART_PAGE: (context) => const CartPage(),
          AppRoutes.HOME: (context) => const ProductOverviewPage(),
          AppRoutes.ORDERS: (context) => const OrdersPage(),
          AppRoutes.PRODUCTS: (context) => const ProductPage(),
          AppRoutes.PRODUCT_FORM: (context) => const ProductFormPage(),
        },
      ),
    );
  }
}
