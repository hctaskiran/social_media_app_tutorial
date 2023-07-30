import 'package:cloud_firestore/cloud_firestore.dart';
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
  // all users
  final usersCollection = FirebaseFirestore.instance.collection('Users');

  Future<void> editField (String field) async {
    String newValue = '';
    await showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        backgroundColor: customColors().grey900color,
        title: Text('Edit $field',
        style: TextStyle(
          color: customColors().whiteColor
        ),
       ),
       content: TextField(
        autofocus: true,
        style: TextStyle(
          color: customColors().whiteColor,
        ),
        decoration: InputDecoration(
            hintText: 'Enter a new $field',
            hintStyle: TextStyle(color: customColors().whiteColor)
        ),
        onChanged:(value) {
          newValue = value;
        },
       ),
       actions: [
        // cansel
        TextButton(
          child: Text('Cancel', style: TextStyle(color: customColors().whiteColor)),
          onPressed:() => Navigator.pop(context),
          ),
        // save
        TextButton(
          child: Text('Save', style: TextStyle(color: customColors().whiteColor)),
          onPressed:() => Navigator.of(context).pop(newValue),
          ),
       ],
      ),
    );

    // update in firebase
    if (newValue.trim().length > 0) {
      // update only if there is sth in tf
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors().grey300color,
      appBar: AppBar(
        title: Text('Profile'), 
        backgroundColor: customColors().grey900color
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
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
              'User Details',
              style: TextStyle(color: customColors().grey700color),
              ),
          ),

          // details

          // nick
          CustomTextBox(
            text: userData['username'], 
            sectionName: 'Nickname:',
            onPressed: () => editField('username'),
            ),

           // bio
          CustomTextBox(
            text: userData['bio'], 
            sectionName: 'About User:',
            onPressed: () => editField('bio'),
            ),

            const SizedBox(height: 50),

           // posts
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Posts of the User',
              style: TextStyle(color: customColors().grey700color),
              ),
          ),
        ],
      );
          } else if (snapshot.hasError){
            return Center(child: Text('Error:${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
      })
    );
  }
}

class customColors {
  final grey900color = Colors.grey.shade900;
  final grey300color = Colors.grey.shade300;
  final grey700color = Colors.grey.shade700;
  final whiteColor = Colors.white;
}