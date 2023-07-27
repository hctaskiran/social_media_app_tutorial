import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_tutorial/components/button.dart';
import 'package:social_media_app_tutorial/components/textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in
  void signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text);
  }

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
          
                Text('Добро пожаловать снова!'),
          
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

                CustomButton(onTap: signIn, text: 'Вход'),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('У вас аккаунта нет?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Зарегистрируйтесь!', 
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