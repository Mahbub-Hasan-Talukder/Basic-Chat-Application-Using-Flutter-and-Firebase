import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          //logo
          const DrawerHeader(child: Center(child: Icon(Icons.message, size: 40,))),

          //home list title
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 15, top: 15),
            child: ListTile(
              title: const Text("H O M E"),
              leading: const Icon(Icons.home),
              onTap: () {},
            ),
          ),

          //setting list title
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 15, top: 15),
            child: ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: () {},
            ),
          ),

          //logout list title
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 15, top: 15),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.logout),
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
