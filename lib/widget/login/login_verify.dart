import 'package:flutter/material.dart';
import 'package:gohub/style/color.dart';
import 'dart:convert';


class LoginVerify extends StatefulWidget {
  final String title;
  final String placeholder;
  final String img_url;
  final GestureTapCallback? onClick;
  final bool obscureText; //是否加密
  final bool lineStretch;
  final ValueChanged<String>? onChange;
  final ValueChanged<bool>? focusChanged;
  final TextInputType? keyboardType;

  const LoginVerify(
      this.title,
      this.placeholder,
      this.img_url,
      {
        Key? key,
        this.onClick,
        this.onChange,
        this.focusChanged,
        this.obscureText = false,
        this.lineStretch = false,
        this.keyboardType,
      }) : super(key: key);

  @override
  State<LoginVerify> createState() => _LoginVerifyState();
}

class _LoginVerifyState extends State<LoginVerify> {
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //光标监听
    _focusNode.addListener(() {
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input(),
            _image(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.lineStretch ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  // 输入组件
  _input() {
    return Expanded(
        child: TextField(
          focusNode: _focusNode,
          onChanged: widget.onChange,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autofocus: !widget.obscureText,
          cursorColor: primary,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          //输入框样式
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              border: InputBorder.none,
              hintText: widget.placeholder,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
        ));
  }
  //验证组件
  _image(){
    var imgCode=widget.img_url.split(',').length>1?widget.img_url.split(',')[1]:"";
    return  GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: imgCode==""?60:120,
        height: 40,
        child:imgCode==""?Image(fit:BoxFit.contain,image: AssetImage("images/bad.png")): Image.memory(base64.decode(imgCode),gaplessPlayback: true,
          fit: BoxFit.cover,),
      ),
    );
  }
}
