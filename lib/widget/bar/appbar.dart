
import 'package:flutter/material.dart';

appBar(String title,String rightTitle,VoidCallback rightButtonClick,{key}){
  return AppBar(
    centerTitle: false,
    titleSpacing: 0,
    leading: const BackButton(),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
    actions: [
      Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFffffff), Color(0xFFffffff)]),
          borderRadius: BorderRadius.all(Radius.circular(100))
          ),

        child: InkWell(
          key: key,
          onTap: rightButtonClick,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          child: Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            alignment: Alignment.center,
            child:  Text(
              rightTitle,
              style: TextStyle(fontSize: 18,color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    ],
  );
}