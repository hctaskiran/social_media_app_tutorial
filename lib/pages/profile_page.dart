import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors().grey300color,
      appBar: AppBar(
        title: Text('Профиль'), 
        backgroundColor: customColors().grey900color
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          // pp
          Icon(Icons.person, size: 70,),

          const SizedBox(height: 10),

          // user mail
          Text(
            currentUser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: customColors().grey700color),
            ),

          const SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Подробно о Ползователе',
              style: TextStyle(color: customColors().grey700color),
              ),
          ),

          // details

          // nick
          CustomTextBox(text: 'hctaskiran', sectionName: 'ПРОЗВИЩЕ:')

           // bio

           // posts
        ],
      ),
    );
  }
}

class customColors {
  final grey900color = Colors.grey.shade900;
  final grey300color = Colors.grey.shade300;
  final grey700color = Colors.grey.shade700;
}