import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final text;
  final prefixIcon;
  const PasswordTextField({super.key, required this.controller, required this.text, this.prefixIcon});
  final TextEditingController? controller; 
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  // final _obscureText = "½";
  bool _isSecure = true;

  void _changeLoading() {
    setState(() {
      _isSecure = !_isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _isSecure,
      // obscuringCharacter: _obscureText,
      autofillHints: [AutofillHints.password],
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade500)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple)
        ),
        hintText: widget.text,
        // suffix: _onVisibilityIcon(),
        fillColor: Colors.grey.shade200,
        filled: true,
        suffixIcon: _onVisibilityIcon(),
        prefixIcon: widget.prefixIcon,
        hintStyle: TextStyle(color: Colors.grey.shade500)
      ),
    );
  }

  IconButton _onVisibilityIcon() {
    return IconButton(
      onPressed: (){
        _changeLoading();    
      },
        icon: AnimatedCrossFade(
          firstChild: Icon(Icons.visibility_outlined, color: Colors.black), 
          secondChild: Icon(Icons.visibility_off_outlined, color: Colors.red,), 
          crossFadeState: _isSecure ? CrossFadeState.showFirst : CrossFadeState.showSecond, duration: Duration(seconds: 2)));
      // icon: Icon(_isSecure ? Icons.visibility : Icons.visibility_off));
  }
}