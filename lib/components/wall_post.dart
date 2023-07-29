import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/likebutton.dart';
import 'package:social_media_app_tutorial/pages/home_page.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postID;
  final List<String> likes;
  const WallPost({
    super.key, 
    required this.message, 
    required this.user, 
    required this.postID, 
    required this.likes
    });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser?.email);
  }

  // toggle like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = 
      FirebaseFirestore.instance.collection('User Posts').doc(widget.postID);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser?.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser?.email])
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [

              // like button
              LikeButton(
                isLiked: isLiked, 
                onTap: toggleLike,
              ),

              // like counter
              const SizedBox(height: 5),

              Text(widget.likes.length.toString(),
              style: TextStyle(color: customColors().grey500color),
              )
            ],
          ),
          const SizedBox(width: 20),
          // msg + user
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.message),
              const SizedBox(height: 10),
              Text(widget.user, style: TextStyle(color: Colors.grey.shade500
              ),
             ),
            ],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}