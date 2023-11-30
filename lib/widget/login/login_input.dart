import 'package:flutter/material.dart';
import 'package:gohub/style/color.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String placeholder;
  final bool obscureText; //是否加密
  final bool lineStretch; 
  final ValueChanged<String>? onChange;
  final ValueChanged<bool>? focusChanged;
  final TextInputType? keyboardType;
  const LoginInput(
    this.title,
    this.placeholder, {
    Key? key,
    this.onChange,
    this.focusChanged,
    this.obscureText = false,
    this.lineStretch = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
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
              width: 80,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
         Padding(
          padding: EdgeInsets.only(left: widget.lineStretch ? 15 : 0),
          child: Divider(
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
}
