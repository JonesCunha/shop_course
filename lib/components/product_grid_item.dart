// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/models/auth.dart';
import 'package:shop_curse/utils/app_routes.dart';
import '../models/cart.dart';
import '../models/product.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    final auth = Provider.of<Auth>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // header: const Text(
        //   'Header',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(color: Colors.red),
        // ),
        footer: SizedBox(
          width: 5,
          child: GridTileBar(
            title: Text(
              maxLines: 2,
              product.name,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
            backgroundColor: Colors.black45,
            leading: Transform(
              transform: Matrix4.translationValues(-16, 5, 0),
              child: IconButton(
                visualDensity: VisualDensity(horizontal: 0.3, vertical: 0.3),
                alignment: Alignment.bottomLeft,
                iconSize: 18,
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).colorScheme.secondary,
                // focusColor: Colors.amber.withOpacity(0.3),
                onPressed: () {
                  product.toggleFavorite(auth.token ?? '');
                },
              ),
            ),
            trailing: Transform(
              transform: Matrix4.translationValues(5, 3, 0),
              child: IconButton(
                visualDensity: VisualDensity(horizontal: 0.3, vertical: 0.3),
                alignment: Alignment.bottomRight,
                iconSize: 18,
                onPressed: () {
                  //codigo abaixo esconde hide se outro for ativado acima.
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Produto Adicionado com Sucesso.'),
                    duration: Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'Desfazer',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ));
                  cart.addItem(product);
                },
                icon: const Icon(Icons.add_shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
        child: GestureDetector(
          // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(),)),
          onTap: () => Navigator.of(context)
              .pushNamed(AppRoutes.PRODUCT_DETAIL_PAGE, arguments: product),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
