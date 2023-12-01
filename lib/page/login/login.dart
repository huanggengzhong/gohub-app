import 'package:flutter/material.dart';
import 'package:gohub/http/dao/login_dao.dart';
import 'package:gohub/utils/string.dart';
import 'package:gohub/widget/bar/appbar.dart';
import 'package:gohub/widget/login/login_button.dart';
import 'package:gohub/widget/login/login_effect.dart';
import 'package:gohub/widget/login/login_input.dart';
import 'package:dio/dio.dart';

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

  @override
  void initState() {
    // TODO: implement initState
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
              LoginInput(
                "密码",
                "请输入密码",
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
                  onPressed: login,
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
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  //提交
  void login() async {
    // print("-----打印一下:$userName ,$password -------");
    // final response = await dio.post('http://110.41.7.44:9000/v1/auth/verify-codes/captcha');
    // print("结果 $response");
    LoginDao.login(userName, password, captcha_id, captcha_answer);
  }
  //初始化
  _init()async{
    // final dio = Dio();
    // final response = await dio.post('http://110.41.7.44:9000/v1/auth/verify-codes/captcha?');
    // print("自己二维码结果 $response");
    var res= await LoginDao.getCaptcha();
    print("封装的二维码结果: $res");
  }
}
