

import 'package:hi_net/request/hi_base_request.dart';

import 'base_request.dart';
class LoginRequest extends BaseRequest{
  //请求类型
  @override
  HttpMethod httpMethod(){
    return HttpMethod.POST;
  }
  //是否需要登录
  @override
  bool needLogin(){
    return false;
  }
  //地址
  @override
  String path(){
    return "/v1/auth/login/using-password";
  }
}

class CaptchaRequest extends BaseRequest{
    //请求类型
  @override
  HttpMethod httpMethod(){
    return HttpMethod.POST;
  }
  //是否需要登录
  @override
  bool needLogin(){
    return false;
  }
  //地址
  @override
  String path(){
    return "/v1/auth/verify-codes/captcha";
  }
}