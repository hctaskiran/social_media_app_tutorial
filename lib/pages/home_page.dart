import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('duck'), backgroundColor: Colors.grey.shade800,actions: [
        IconButton(onPressed: signOut, icon: Icon(Icons.logout))
      ],),
    );
  }
}