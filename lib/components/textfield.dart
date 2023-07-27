import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final labelText;
  final prefixIcon;
  final bool obscureText;

  const CustomTextField({
    super.key, 
    required this.controller, 
    required this.hintText, 
    required this.obscureText,
     this.labelText,
     this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade500)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple)
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        hintStyle: TextStyle(color: Colors.grey[500])
      ),
    );
  }
}