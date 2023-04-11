import 'package:blog_app/Login_Page.dart';
import 'package:blog_app/component.dart';
import 'package:blog_app/signup_page.dart';
import 'package:blog_app/splash%20screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:SplashScreen(),
    theme:ThemeData(
      primarySwatch: Colors.orange
    ),
    );
  }
}

class OptionScreen extends StatelessWidget {

  const OptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               Image(image:AssetImage('images/blog_logo.jpg') ),
            SizedBox(height: 30,),
            RoundButton(title: 'Login', onpress: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) =>  LogIn())));
            }),
            SizedBox(height: 25,),
            RoundButton(title: 'SignUp', onpress: (){
              Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUp())));
            }),

          ],
        ),
      ),
    );
  }
}
