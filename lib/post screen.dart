import 'package:blog_app/blogs_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'main.dart';
class Postscreen extends StatefulWidget {
  const Postscreen({Key? key}) : super(key: key);

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  //it is the object of database storage.
  final dbref=FirebaseDatabase.instance.ref().child('posts');
  FirebaseAuth auth=FirebaseAuth.instance;
  final searchcontroller=TextEditingController();
  String search='';

  @override
  Widget build(BuildContext context) {
    return 
        Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
            centerTitle: true,
            title: const  Text(" Blogs"),
            actions: [
              IconButton(
                  onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => BlogsPage())));
              }, icon: Icon(Icons.add)),
              IconButton(onPressed: (){
                auth.signOut().toString();
                Navigator.push(context, MaterialPageRoute(builder: ((context) => OptionScreen())));
              }, icon: Icon(Icons.logout))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                  child: TextFormField(
                    controller:searchcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      labelText: 'Search blog with title',
                    ),
                    onChanged: (String value) {
                            setState(() {

                            });

                    },
                  ),
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: dbref.child('Post_list'),
                    defaultChild: const Text('Empty'),
                    itemBuilder: (context, snapshot, animation, index) {
                         final title=snapshot.child('post_title').value.toString();
                           if(searchcontroller.text.isEmpty){
                                 return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("User ID: "+snapshot.child('email').value.toString(),style: TextStyle(fontSize: 18,backgroundColor: Colors.tealAccent.shade100),),
                               PopupMenuButton(
                                 itemBuilder: (context) => [
                                 PopupMenuItem(
                                     child: ListTile(

                                       leading: Icon(Icons.edit),
                                       title: Text('Edit'),
                                       onTap: (){

                                       },
                                     )),
                                   PopupMenuItem(
                                       child: ListTile(

                                         leading: Icon(Icons.delete),
                                         title: Text('Delete'),
                                         onTap: (){

                                         },
                                       )),

                               ],)
                             ],
                           ),
                           Container(
                             height: MediaQuery.of(context).size.height *.5,
                             width: MediaQuery.of(context).size.width*0.99,
                             child: FadeInImage.assetNetwork(
                                 placeholder: 'images/blog_logo.jpg',
                                 image:snapshot.child("post_image").value.toString()),
                           ),

                           Container(
                               decoration:BoxDecoration(
                                   color: Colors.orange.shade100
                               ),
                               child: Text('Title:      '+snapshot.child('post_title').value.toString(),style: TextStyle(color: Colors.red.shade700,fontSize: 20,fontWeight: FontWeight.bold),)

                           ),
                           SizedBox(height: 8,),
                           Container(
                               alignment:Alignment.center,
                               decoration:BoxDecoration(
                                   color: Colors.black12
                               ),
                               child: Text(snapshot.child('post_description').value.toString(),style: TextStyle(fontSize: 18),)

                           ),
                           Divider(
                             thickness: 2,
                             color:Colors.orange,
                           ), SizedBox(height: 15,)



                         ],
                       );
                     }
                     else if (title.toLowerCase().contains(searchcontroller.text.toString())){
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("User ID: "+snapshot.child('email').value.toString(),style: TextStyle(fontSize: 18,backgroundColor: Colors.tealAccent.shade100),),
                           Container(
                             height: MediaQuery.of(context).size.height *.5,
                             width: MediaQuery.of(context).size.width*0.99,
                             child: FadeInImage.assetNetwork(
                                 placeholder: 'images/blog_logo.jpg',
                                 image:snapshot.child("post_image").value.toString()),
                           ),

                           Container(
                               decoration:BoxDecoration(
                                   color: Colors.orange.shade100
                               ),
                               child: Text('Title:      '+snapshot.child('post_title').value.toString(),style: TextStyle(color: Colors.red.shade700,fontSize: 20,fontWeight: FontWeight.bold),)

                           ),
                           SizedBox(height: 8,),
                           Container(
                               alignment:Alignment.center,
                               decoration:BoxDecoration(
                                   color: Colors.black12
                               ),
                               child: Text(snapshot.child('post_description').value.toString(),style: TextStyle(fontSize: 18),)

                           ),
                           Divider(
                             thickness: 2,
                             color:Colors.orange,
                           ), SizedBox(height: 15,)



                         ],
                       );
                     } else {
                       Container();
                     };





                    },),
                ),


              ],
            ),
          ),
        );
  }
}

