import 'package:flutter/material.dart';
import 'package:gohub/http/dao/login_dao.dart';
import 'package:gohub/utils/string.dart';
import 'package:gohub/widget/common/appbar.dart';
import 'package:gohub/widget/login/login_button.dart';
import 'package:gohub/widget/login/login_effect.dart';
import 'package:gohub/widget/login/login_input.dart';
import 'package:gohub/widget/login/login_verify.dart';
import 'dart:convert';
import 'package:gohub/utils/toast.dart';
import 'package:gohub/route/navigator.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool protect = false; //是否遮眼
  bool loginEnable = false; //是否可以提交
  String? userName;
  String? password;
  String captcha_id="";
  String captcha_answer="";
  String img_url="";

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar("密码登录", "注册", () {}, key: const Key('registration')),
        body: Container(
          child: ListView(
            children: [
              LoginEffect(protect: protect),
              LoginInput('用户名', '请输入用户名', onChange: (value) {
                userName = value;
                checkInput();
              }),
              LoginVerify("图形验证码", "请输入图形验证码",img_url,keyboardType:TextInputType.number,onChange: (value){
                captcha_answer=value;
                checkInput();
              }, onClick:(){
                //点击事件
                _init();
              }),
              LoginInput(
                "登录密码",
                "请输入登录密码",
                obscureText: true,
                onChange: (value) {
                  password = value;
                  checkInput();
                },
                focusChanged: (value) {
                  setState(() {
                    protect = value;
                  });
                },
              ),

              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: LoginButton(
                  '登录',
                  enable: loginEnable,
                  onPressed: _login,
                ),
              )
            ],
          ),
        ) //
        );
  }

  //检查
  checkInput() {
    bool enable;
    enable = true;
    //待解开
    // if (isNotEmpty(userName) && isNotEmpty(password) &&isNotEmpty(captcha_answer)) {
    //   enable = true;
    // } else {
    //   enable = false;
    // }
    setState(() {
      loginEnable = enable;
    });
  }

  //提交
  void _login() async {

   var res= await LoginDao.login(userName, password, captcha_id, captcha_answer);

   if(res["code"]!=200){
     $Toast.show(json.encode(res["errors"]));
   }else{
     $Toast.show("登录成功");

     HiNavigator.getInstance().onJumpTo(RouteStatus.home);
   }
  }
  //初始化
  _init()async{
    var res= await LoginDao.getCaptcha();
    if(res["code"]==200){
    setState(() {
      img_url=res["data"];
      captcha_id=res["captcha_id"];
    });
    }
  }
}
