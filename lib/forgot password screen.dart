import 'package:blog_app/Login_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'component.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FirebaseAuth auth= FirebaseAuth.instance;
  final formkey= GlobalKey<FormState>();
  bool showSpinner=false;
  final  emailcontroller=TextEditingController();
  final  Passwordcontroller=TextEditingController();
  var   email='';
  var  password='';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const  Text("ForgotPassword"),
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
                          child: RoundButton(
                              title: 'Recover Password',
                              onpress:()async{
                                if(formkey.currentState!.validate()){
                            setState(() {
                              showSpinner=true;
                            });
                            try{

                              auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value){
                                TostMessage('Please Your Email');
                                Navigator.push(context, MaterialPageRoute(builder: ((context) => LogIn())));
                                setState(() {
                                  showSpinner=false;
                                });
                              }).onError((error, stackTrace){
                                TostMessage(error.toString());
                                setState(() {
                                  showSpinner=false;
                                });

                              });
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


