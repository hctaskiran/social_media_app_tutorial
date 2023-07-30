import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app_tutorial/auth/auth.dart';
import 'package:social_media_app_tutorial/auth/login_or_register.dart';
import 'package:social_media_app_tutorial/pages/login_page.dart';
import 'package:social_media_app_tutorial/pages/register_page.dart';
import 'firebase_options.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // supportedLocales: L10n.all,
      theme: ThemeData(),
      home: AuthPage()
    );
  }
}

