import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
   RoundButton({Key? key,required this.title, required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
          borderRadius: BorderRadius.circular(10),
      color: Colors.orange,
      child: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        child: Text(title,style: TextStyle(color: Colors.white),),
        onPressed:  onpress,
      ),
    );
  }
}
