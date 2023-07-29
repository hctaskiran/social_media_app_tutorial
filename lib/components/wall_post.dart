import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  const WallPost({super.key, required this.message, required this.user});

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
          Container(
            // pp
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade400,
             ),
             padding: EdgeInsets.all(10),
             child: Icon(Icons.person),
          ),
          const SizedBox(width: 20),
          // msg + user
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              const SizedBox(height: 10),
              Text(user, style: TextStyle(color: Colors.grey.shade500
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