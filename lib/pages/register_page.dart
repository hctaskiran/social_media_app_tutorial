import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPagePageState();
}

class _RegisterPagePageState extends State<RegisterPage> {

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
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        
        );
        // pop loading
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading
        Navigator.pop(context);
        // show error to user
        displayMessage(e.code);
      }

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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                Icon(Icons.lock, size: 100),
          
                const SizedBox(height: 50),        
          
                Text('Присоединяйтесь к нам 1 щёлчком!'),
          
                const SizedBox(height: 25),
          
                CustomTextField(
                  controller: emailController, 
                  hintText: 'Почта', 
                  obscureText: false, 
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: passwordController, 
                  hintText: 'Пароль', 
                  obscureText: true, 
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: confirmPasswordController, 
                  hintText: 'Проверка пароля', 
                  obscureText: true, 
                ),

                const SizedBox(height: 10),

                CustomButton(onTap: signUp, text: 'Создать'),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Уже создали аккаунт?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Нажмите для входа!', 
                      style: TextStyle(
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