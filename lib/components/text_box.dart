import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const CustomTextBox({super.key, required this.text, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColors().grey200color,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                
               ),
              ),

              // edit button
              IconButton(
                onPressed: (){}, 
                icon: Icon(
                  Icons.settings, 
                  color: customColors().grey500color,
                ),
              ),
            ],
          ),

          Text(text)
        ],
      ),
    );
  }
}

class customColors {
  final grey200color = Colors.grey.shade200;
  final grey500color = Colors.grey.shade500;
}