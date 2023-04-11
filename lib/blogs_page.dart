import 'dart:io';
import 'package:blog_app/component.dart';
import 'package:blog_app/main.dart';
import 'package:blog_app/post%20screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class BlogsPage extends StatefulWidget {
  const BlogsPage({Key? key}) : super(key: key);

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  FirebaseAuth auth=FirebaseAuth.instance;
  final titlecontroller=TextEditingController();
  final descriptioncontroller=TextEditingController();

   final database_postref=FirebaseDatabase.instance.ref().child('posts');
   firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
   bool ShowSpiner=false;

  File? image ;
  final picker = ImagePicker();
  Future getImageGallery()async{
    final pickedFile= await picker.pickImage(source:ImageSource.gallery,);
    setState(() {
      if(
      pickedFile != null
      ){
        image= File(pickedFile.path);

      }else{
       Icon(Icons.person);
      }

    });
  }
   Future getImageCamera()async{
     final pickedFile=await picker.pickImage(source:ImageSource.camera);
     setState(() {
       if (pickedFile != null) {
         image=File(pickedFile.path);
       } else {
         Icon(Icons.person);
       }
     });
   }
   void dialog(context){
     showDialog(
         context: context,
         builder: (BuildContext context){
           return AlertDialog(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
               content: Container(
                 height: 120,
                 decoration: BoxDecoration(
                   color: Colors.orange.shade100,
                 ),
                 child: Column(
                   children: [
                     InkWell(
                       onTap: (){
                         getImageCamera();
                         Navigator.pop(context);
                       },
                       child:ListTile(
                         leading: Icon(Icons.camera),
                         title: Text('Camera'),
                       ),
                     ),
                     InkWell(
                       onTap: (){
                         getImageGallery();
                         Navigator.pop(context);
                       },
                       child:ListTile(
                         leading: Icon(Icons.photo_library),
                         title: Text('Upload from gallery'),
                       ),
                     ),
                   ],
                 ),
               )

           );
         }
     );
   }

  @override

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: ShowSpiner,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const  Text("Create New Blogs"),
          actions: [
            IconButton(onPressed: (){
              auth.signOut().toString();
              Navigator.push(context, MaterialPageRoute(builder: ((context) => OptionScreen())));
            }, icon: Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                   dialog(context);
                },
                child:Container(
                    height: MediaQuery.of(context).size.height *.5,
                    width: MediaQuery.of(context).size.width*0.99,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: image!=null ? ClipRect(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        image!.absolute,
                        height:100,
                        width: 100,
                        fit: BoxFit.cover,

                      ),
                    )
                  ) : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange.shade100,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.camera_alt),
                    ),
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 15),
                child: TextFormField(
                  controller: titlecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    ),
                    labelText: 'Title'
                  ),



                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 15),
                child: TextFormField(
                  controller: descriptioncontroller,
                  minLines: 1,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      labelText: 'description'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0,horizontal: 15),
                child: RoundButton(title: 'Upload',
                    onpress: () async {
                  setState(() {
                    ShowSpiner=true;
                  });
                  if(image!=null) {
                     int date=DateTime.now().millisecondsSinceEpoch;
                     //creation of database reference of image
                     firebase_storage.Reference image_ref=firebase_storage.FirebaseStorage.instance.ref('/blogapp$date');
                    //uploading image with path
                     UploadTask uplodetask=image_ref.putFile(image!.absolute);
                     //wait for uploading
                     await Future.value(uplodetask);
                     var newurl=await image_ref.getDownloadURL();
                     final User? user= auth.currentUser;
                     database_postref.child('Post_list').child(date.toString()).set(
                         {
                           'post_id':date.toString(),
                           'post_image':newurl.toString(),
                           'post_title':titlecontroller.text.toString(),
                           'post_description':descriptioncontroller.text.toString(),
                           'email':user!.email.toString(),
                           'user_time':date.toString(),
                           'user_Id':user!.uid.toString(),
                         }).then((value){
                           TostMessage('Post added');
                           Navigator.push(context, MaterialPageRoute(builder: ((context) => Postscreen())));
                       setState(() {
                         ShowSpiner=false;

                       });

                     })
                         .onError((error, stackTrace){
                       setState(() {
                         ShowSpiner=false;
                         TostMessage(error.toString());
                       });
                     });

                   }
                   else(e){
                     setState(() {
                       ShowSpiner=false;
                       TostMessage(e.toString());
                     });
                   };

                }),
              )

            ],
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

