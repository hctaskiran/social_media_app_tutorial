import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;
  const Comment({super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColors().grey300color,
        borderRadius: BorderRadius.circular(6)
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // comment
          Text(text),

          const SizedBox(height: 5,),
          // usr 
          Row(
            children: [
              Text(user, style: TextStyle(color: customColors().grey500color)),
              Text(' | ', style: TextStyle(color: customColors().grey500color)),
              Text(time, style: TextStyle(color: customColors().grey500color))
            ],
          ),
        ],
      ),
    );
  }
}

class customColors {
  final grey300color = Colors.grey.shade300;
  final grey500color = Colors.grey.shade500;
}