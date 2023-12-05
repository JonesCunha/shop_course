import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/utils/app_routes.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
        radius: 30,
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit_rounded),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Excluir o item : ${product.name}'),
                      content: Text('Tem certeza?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<ProductList>(context, listen: false)
                                .removeItem(product);
                            Navigator.of(context).pop();
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    );
                  },
                );
              },
              color: Theme.of(context).colorScheme.error,
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
      title: Text(product.name),
    );
  }
}
