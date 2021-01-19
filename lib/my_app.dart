import 'package:flutter/material.dart';
import 'package:login_and_sign_up_task/screens/login_screen.dart';
import 'package:login_and_sign_up_task/screens/show_logo_screen.dart';
import 'package:login_and_sign_up_task/screens/sign_up_sceen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      initialRoute: LoginScreen.routName,
      routes: {
        LoginScreen.routName: (context) => LoginScreen(),
        SignUpScreen.routName: (context) => SignUpScreen(),
        ShowLogoScreen.routName: (context) => ShowLogoScreen(),
      },
    );
  }
}
