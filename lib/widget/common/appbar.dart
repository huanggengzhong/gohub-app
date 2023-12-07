
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
        child: GestureDetector(
          key: key,
          onTap: rightButtonClick,
          child: Container(
            padding: EdgeInsets.only(left: 15,right: 15),
            alignment: Alignment.center,
            child:  Text(
              rightTitle,
              style: TextStyle(fontSize: 18,color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      )
    ],
  );
}