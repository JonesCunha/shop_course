// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_curse/models/auth.dart';
import 'package:shop_curse/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  final String urlImage =
      'https://static.vecteezy.com/system/resources/thumbnails/020/899/523/small/happy-dog-smiling-dog-on-transparent-background-png.png';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Auth>(context);
    final email = provider.getEmail.toString();
    return Drawer(
      // backgroundColor: const Color.fromRGBO(255, 191, 176, 130),
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(urlImage),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 191, 176, 130),
            titleSpacing: 2,
            title: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bem Vindo',
                  style: TextStyle(letterSpacing: 2, fontSize: 16),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(email),
                )
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.AUTH_OR_HOME_PAGE),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_applications),
            title: const Text('Gerenciar Produtos'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair/Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Certeza que Deseja sair?'),
                      icon: Icon(Icons.warning),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Provider.of<Auth>(context, listen: false).logout();
                            Navigator.of(context).pushReplacementNamed(
                                AppRoutes.AUTH_OR_HOME_PAGE);
                          },
                          child: Text('Sim'),
                        ),
                        TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text('Não'))
                      ],
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
