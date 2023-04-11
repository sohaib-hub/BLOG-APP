import 'package:blog_app/forgot%20password%20screen.dart';
import 'package:blog_app/post%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'blogs_page.dart';
import 'component.dart';
import 'main.dart';
class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  FirebaseAuth auth= FirebaseAuth.instance;
  final formkey= GlobalKey<FormState>();
  bool showSpinner=false;
  final  emailcontroller=TextEditingController();
  final  Passwordcontroller=TextEditingController();
  var   email='';
  var  password='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const  Text("Login"),
        ),
        body:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 160,
                  child: Image(image: AssetImage('images/blog_logo.jpg')),
                ),
                // Text('SignUp',style: TextStyle(color: Colors.orange,fontSize: 30,fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Form(
                    key: formkey,
                    child:Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                          child: TextFormField(
                            controller: emailcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              prefixIcon: Icon(Icons.mail),
                              hintText: 'Email',
                              labelText: 'Enter Your Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email=value;
                            },
                            validator: (value) {
                              return value!.isEmpty ? 'enter Email' : null;
                            },

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                          child: TextFormField(

                            controller:Passwordcontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              ),
                              prefixIcon: Icon(Icons.lock),
                              hintText: 'Password',
                              labelText: 'Enter Your Password',
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              password= value;
                            },
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return value!.isEmpty ? 'enter password' : null;
                            },

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0,top: 15),
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: ((context) => ForgotPassword())));
                          },
                              child: const Text('Forgot Password!')),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                          child: RoundButton(
                              title: 'Login', onpress:()async{if(formkey.currentState!.validate()){
                            setState(() {
                              showSpinner=true;
                            });
                            try{
                              final user=await auth.signInWithEmailAndPassword(email: email.toString().trim(),
                                  password: password.toString().trim());
                              if(user!=null){
                                TostMessage('successfully login');
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => Postscreen())));
                                setState(() {
                                  showSpinner=false;
                                });

                              }
                            } catch(e){
                              print(e.toString());
                              TostMessage(e.toString());
                              setState(() {
                                showSpinner=false;
                              });
                            }




                          };




                          }),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
void TostMessage( String message){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );

}

