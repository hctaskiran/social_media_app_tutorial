import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.icon, required this.text, required this.onTap});

  final void Function()? onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon, 
          color: customColors().whiteColor
          ),
          onTap: onTap,
        title: Text(text, 
          style: TextStyle(
            color: customColors().whiteColor,
            fontSize: 18
            ),
          ),
      ),
    );
  }
}

class customColors {
  final whiteColor = Colors.white;
}