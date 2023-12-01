import 'package:gohub/http/request/base_request.dart';
import 'package:gohub/http/request/login_request.dart';
import 'package:hi_net/hi_net.dart';

class LoginDao {

  static getCaptcha()async{
    BaseRequest request= CaptchaRequest();
   return await HiNet.getInstance().fire(request);

  }
  static login(String? name,String? password,String captcha_id,String captcha_answer){
    return _send(name,password,captcha_id,captcha_answer);
  }

  static _send(String? name,String? password,String captcha_id,String captcha_answer)async{
    BaseRequest request =LoginRequest();
    
    request
    .add("login_id", name!)
    .add("password", password!)
    .add("captcha_id", captcha_id)
    .add("captcha_answer", captcha_answer);

    var result =await HiNet.getInstance().fire(request);
    print("登录结果信息打印:$result");
  }
}