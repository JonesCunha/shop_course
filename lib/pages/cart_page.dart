// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/components/cart_item.dart';

import '../models/cart.dart';
import '../models/order_list.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();
    bool hasItens = false;

    if (items.isEmpty) {
      hasItens = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor:  const Color.fromARGB(255, 191, 176, 130),
      ),
      body: hasItens
          ? Center(
              child: Text('Nao ha itens em seu carrinho'),
            )
          : Column(children: [
              Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(
                          'R\$${cart.totalAmout.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge
                                  ?.color),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Provider.of<OrderList>(context, listen: false)
                              .addOrder(cart);
                          cart.clear();
                          setState(() {
                            hasItens = false;
                          });
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).primaryColor),
                        child: Text('Comprar'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => CartItemWidget(
                    cartItem: items[index],
                  ),
                ),
              ),
            ]),
    );
  }
}
