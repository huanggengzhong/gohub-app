import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;
  const LoginButton(this.title, {Key?key,this.enable=true,this.onPressed}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        onPressed: enable?onPressed:null,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
        height: 45,
        disabledColor: primary[50],
        color: primary,
        child: Text(title,style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
    );
  }
}