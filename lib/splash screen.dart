import 'dart:async';

import 'package:blog_app/Login_Page.dart';
import 'package:blog_app/blogs_page.dart';
import 'package:blog_app/main.dart';
import 'package:blog_app/post%20screen.dart';
import 'package:blog_app/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


 class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);

   @override
   State<SplashScreen> createState() => _SplashScreenState();
 }

 class _SplashScreenState extends State<SplashScreen> {
   FirebaseAuth auth =FirebaseAuth.instance;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
 final user=auth.currentUser;
    if(user!=null)
    {
      Timer(Duration(seconds: 3),()=>
        Navigator.push(context, MaterialPageRoute(builder: ((context) => Postscreen())))
    );

    }else
      {Timer(Duration(seconds: 3),()=>
          Navigator.push(context, MaterialPageRoute(builder: ((context) => OptionScreen()))));

      }
  }
   @override
   Widget build(BuildContext context) {
     return 
         Scaffold(
           body: Column(
            mainAxisAlignment: MainAxisAlignment.center,     
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/blog_logo.jpg", ))
            ], 
            ),
         );
   }
 }
