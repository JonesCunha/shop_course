import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/components/app_drawer.dart';
import 'package:shop_curse/components/order_widget.dart';

import '../models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        //automaticallyImplyLeading: false,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (context, index) =>
            OrderWidget(order: orders.items[index]),
      ),
    );
  }
}
