// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_curse/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // backgroundColor: const Color.fromRGBO(255, 191, 176, 130),
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            leading: Padding(padding: EdgeInsets.all(5), child: CircleAvatar()),
            backgroundColor: const Color.fromARGB(255, 191, 176, 130),
            titleSpacing: 2,
            title: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Bem Vindo',
                      style: TextStyle(letterSpacing: 2, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [Text('Santigo')],
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
                Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME_PAGE);
            }
          ),
        ],
      ),
    );
  }
}
