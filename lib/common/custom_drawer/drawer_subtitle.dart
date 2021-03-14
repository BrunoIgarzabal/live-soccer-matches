import 'package:flutter/material.dart';

class DrawerSubtitle extends StatelessWidget {

  const DrawerSubtitle({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 15),
      child: Text(title, style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w300,
        fontSize: 18
      ),) ,
    );
  }
}
