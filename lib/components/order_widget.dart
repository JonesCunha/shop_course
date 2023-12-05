// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key, required this.order});
  final Order order;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final DateFormat formatData = DateFormat('dd/MM/yyyy hh:mm');
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(formatData.format(widget.order.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(Icons.expand_more),
            ),
          ),
          if (_expanded)
            Container(
              height: (widget.order.products.length * 24 ) +20 ,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity}x R\$ ${product.price}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    );
                  },
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}
