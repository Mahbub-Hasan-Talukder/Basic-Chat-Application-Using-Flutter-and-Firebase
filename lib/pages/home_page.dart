import 'package:flutter/material.dart';
import 'package:minimal_chat/auth/auth_service.dart';
import 'package:minimal_chat/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // void logout(){
  //   final auth = AuthService();
  //   auth.signOut();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Min chat app'),
        actions: [

          //logout button
          // IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),

      //drawer
      drawer: const MyDrawer(),

    );
  }
}
