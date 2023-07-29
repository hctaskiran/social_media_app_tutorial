import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/drawer.dart';
import 'package:social_media_app_tutorial/components/textfield.dart';
import 'package:social_media_app_tutorial/components/wall_post.dart';
import 'package:social_media_app_tutorial/pages/profile_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  // text controller

  final textController = TextEditingController();
  
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postMessage() {
    // only post if textfield is filled
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User Posts').add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }

    // clear TF
    setState(() {
      textController.clear();
    });
  }

  // navigate to profile
  void goProfilePage() {
    // pop menu drawer
    Navigator.pop(context);

    // go to profile page
    Navigator.push(context, 
    MaterialPageRoute(
      builder:(context) => ProfilePage()
    )
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors().grey300color,
      appBar: AppBar(
        title: Text('Ducky'), 
        backgroundColor: customColors().grey900color,        
      ),
      drawer: CustomDrawer(
        onProfileTap: goProfilePage, 
        onSignOutTap: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: 
              StreamBuilder(
                stream: 
                  FirebaseFirestore.instance
                  .collection('User Posts')
                  .orderBy('TimeStamp',descending: false)
                  .snapshots(),
                builder:(context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context, index) {
                      final post = snapshot.data!.docs[index];   
                      return WallPost(
                        message: post['Message'], 
                        user: post['UserEmail'],
                        likes: List<String>.from(post['Likes'] ?? []), 
                        postID: post.id,

                      );
                    }
                   );
                  } else if (snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return Center(child: CircularProgressIndicator());
                }
               ),
              ),

            // post 
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: 
                      CustomTextField(
                        controller: 
                        textController, 
                        hintText: customTexts().publishMsg, 
                        obscureText: false
                    ),
                  ),

                  // post button
                  IconButton(onPressed: postMessage, icon: Icon(Icons.send_outlined)),
                ],
              ),
            ),
            



            // logged in as
            Text(
            customTexts().loggedMsg + currentUser.email!, 
            style: TextStyle(color:customColors().grey500color)),
            customSizedBoxes().elliHeBox
          ],
        ),
      ),
    );
  }
}

class customTexts {
  final String loggedMsg = 'Вошли как: ';
  final String publishMsg = 'Публикация';
}

class customIcons {
  final logoutIcon = Icon(Icons.logout);
}

class customColors {
  final grey500color = Colors.grey.shade500;
  final grey900color = Colors.grey.shade900;
  final grey300color = Colors.grey.shade300;
}

class customSizedBoxes {
  final elliHeBox = SizedBox(height: 50);
}