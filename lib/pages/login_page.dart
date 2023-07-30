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

    // loading circle
    showDialog(
      context: context, 
      builder:(context) => const Center(child: CircularProgressIndicator()));


    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
      Navigator.pop(context);

      // pop loading
    //   if (context.mounted) Navigator.pop(context);
    // } on FirebaseAuthException catch (e) {
    //   Navigator.pop(context);
    //   displayMessage('Почта не найдена');
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Wrong e-mail, try again'),
        );
      }  
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Wrong password, try again'),
        );
      }  
    );
  }
  
  

  // dialog message display

  void displayMessage(String message) {
    showDialog(context: context, builder:(context) => AlertDialog(
      title: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors().grey300color,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                Icon(Icons.lock, size: 100),
          
                const SizedBox(height: 30),        
          
                Text('Welcome back again!', style: TextStyle(fontSize: 18),),
          
                const SizedBox(height: 25),
          
                CustomTextField(
                  controller: emailController, 
                  hintText: 'Enter the e-mail', 
                  labelText: 'E-Mail',
                  prefixIcon: Icon(Icons.email, color: customColors().grey700color),
                  obscureText: false, 
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  controller: passwordController, 
                  hintText: 'Enter the password',
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.key, color: customColors().grey700color), 
                  obscureText: true, 
                ),

                customSizedBoxes().onluSized,

                CustomButton(onTap: signIn, text: 'Sign In'),

                customSizedBoxes().yirmibesSized,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Haven\'t created an account yet?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Create now!', 
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: customColors().blueColor,
                        fontWeight: FontWeight.bold),
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class customColors {
  final blueColor = Colors.blue;
  final grey700color=  Colors.grey.shade700;
  final grey300color = Colors.grey.shade300;
}

class customSizedBoxes {
  final yirmibesSized = SizedBox(height: 25);
  final onluSized = SizedBox(height: 10);
}