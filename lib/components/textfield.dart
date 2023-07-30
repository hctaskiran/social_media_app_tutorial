import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade500)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple)
        ),
        fillColor: Colors.grey[200],
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        hintStyle: TextStyle(color: Colors.grey[500])
      ),
    );
  }
}