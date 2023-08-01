import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/custom_password_field.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPagePageState();
}

class _RegisterPagePageState extends State<RegisterPage> {

  bool _isVisible = true;

  void _toggleVisibility(params) {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void signUp() async {
    // loading circle
    showDialog(
      context: context, 
      builder:(context) => const Center(child: CircularProgressIndicator()));

      // password match
      if (passwordController.text != confirmPasswordController.text) {
        // pop loading
        Navigator.pop(context);
        // error
        displayMessage('Паролы не совпадаются');
        return;
      }

      // try creating user
      try {

        // create the user
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        );
        
        // after user has been created, create a new doc in cloud called Users
        FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.email)
        .set({
          'username' :emailController.text.split('@')[0], // init username
          'bio' : 'empty bio' // init empty bio
          // add more if needed
        });

    

        // pop loading
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading
        Navigator.pop(context);
        if (e.code == 'email-already-in-use') {
          emailInUseMessage();
        }
      }

  }

    void emailInUseMessage() {
      showDialog(
        context: context, 
        builder:(context) {
          return const AlertDialog(
            title: Text('Email is already in use!'),
          );
        }
      );
    }

    void displayMessage(String message) {
      showDialog(context: context, builder:(context) => AlertDialog(
        title: Text(message),
      ));
    }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 150),
          
                Icon(Icons.lock, size: 100),
          
                const SizedBox(height: 50),        
          
                Text('Join us with a simple tap!', style: TextStyle(fontSize: 18)),
          
                const SizedBox(height: 25),
          
                CustomTextField(
                  controller: emailController, 
                  hintText: 'Enter an e-mail', 
                  obscureText: false, 
                ),

                const SizedBox(height: 10),

                CustomTextField(controller: passwordController, hintText: 'Enter a password', obscureText: _isVisible),

                const SizedBox(height: 10),

                PasswordTextField(controller: confirmPasswordController, text: 'Confirm the password', ),

                const SizedBox(height: 10),

                CustomButton(onTap: signUp, text: 'Create'),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Tap to sign in!', 
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue, 
                        fontWeight: FontWeight.bold),),
                    )
                  ],
                )
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}