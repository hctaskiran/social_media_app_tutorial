
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/comment.dart';
import 'package:social_media_app_tutorial/components/comment_button.dart';
import 'package:social_media_app_tutorial/components/likebutton.dart';
import 'package:social_media_app_tutorial/helper/helper.dart';
import 'package:social_media_app_tutorial/pages/home_page.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postID;
  final List<String> likes;
  const WallPost({
    super.key, 
    required this.message, 
    required this.user, 
    required this.postID, 
    required this.likes, 
    required this.time
    });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {

  // user
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  final _commentTextController = TextEditingController();
  

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

    

    // dialog box for adding comment
    


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

  

  // add comments
    void addComment(String commentText) {
      FirebaseFirestore.instance
      .collection('Users Posts')
      .doc(widget.postID)
      .collection('Comments')
      .add({
        'CommentText': commentText,
        'CommentedBy': currentUser!.email,
        'CommentTime': Timestamp.now()
      }
     );
    }

  void showCommentDialog() {
      showDialog(
        context: context, 
        builder:(context) => AlertDialog(
          backgroundColor: customColors().grey900color,
          title: Text('Add Comment', style: TextStyle(color: customColors().whiteColor),),
          content: TextField(
            autofocus: true,
            controller: _commentTextController,
            style: TextStyle(color: customColors().whiteColor),
            decoration: InputDecoration(
              hintStyle: TextStyle(color: customColors().whiteColor),
              hintText: 'Write your comment...'
              
              
            ),
          ),
          actions: [
            // cansel
            TextButton(
              onPressed:()  {
                Navigator.pop(context);
                _commentTextController.clear();
                }, 
              child: Text('Cancel', style: TextStyle(color: customColors().whiteColor)), ),

            // post save
            TextButton(
              
              onPressed:() {
                Navigator.pop(context);

                addComment(_commentTextController.text);
                _commentTextController.clear();
              }, 
              child: Text('Post',
              style: TextStyle(color: customColors().whiteColor)
              ),
              
              ),

            
          ],
        )
      );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColors().grey200color,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // msg + user
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.message),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(widget.user, style: TextStyle(color: customColors().grey500color)),
                  Text(' | ', style: TextStyle(color: customColors().grey500color)),
                  Text(widget.time, style: TextStyle(color: customColors().grey500color))
           ],
          ),
         ],
        ),
          SizedBox(height: 20,),

          // like
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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

              // comment
              Column(
                children: [
                  // like button
                  CommentButton(onTap: showCommentDialog),

                  // like counter
                  const SizedBox(height: 5),

                  Text('0',
                  style: TextStyle(color: customColors().grey500color),
                  )
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          
          // comments
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
            .collection('Users Posts')
            .doc(widget.postID)
            .collection('Comments')
            .orderBy('CommentTime', descending: true)
            .snapshots(),
            builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator()
               );
              }

              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  final commentData = doc.data() as Map<String, dynamic>;
                  return Comment(
                    text: commentData['CommentText'], 
                    user: commentData['CommentedBy'], 
                    time: formatDate(commentData['CommentTime']));
                }).toList(),
              );
            }
          )
        ],
      ),
    );
  }
}

class customColors {
  final grey900color = Colors.grey.shade900;
  final whiteColor = Colors.white;
  final grey500color = Colors.grey.shade500;
  final grey200color = Colors.grey.shade200;
}