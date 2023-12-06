import 'package:gohub/http/request/base_request.dart';
import 'package:gohub/http/request/login_request.dart';
import 'package:hi_net/hi_net.dart';
import 'package:hi_cache/hi_cache.dart';
class LoginDao {

  static const AUTHOTIZATION_TOKEN = "Authorization";
  static getCaptcha()async{
    BaseRequest request= CaptchaRequest();
   return await HiNet.getInstance().fire(request);

  }
  static login(String? name,String? password,String captcha_id,String captcha_answer){
    print("-------2023年12月06日10:57:45-------");
    return _send(name,password,captcha_id,captcha_answer);
  }

  static _send(String? name,String? password,String captcha_id,String captcha_answer)async{
    BaseRequest request =LoginRequest();
    request
    .add("login_id", name!)
    .add("password", password!)
    .add("captcha_id", captcha_id)
    .add("captcha_answer", captcha_answer);

    var result= await HiNet.getInstance().fire(request);
    //保存token

    if(result['code']==200 && result['token']!=null){
      HiCache.getInstance().setString(AUTHOTIZATION_TOKEN, result['token']);
    }
    return result;
  }
  static getToken() {
    return HiCache.getInstance().get(AUTHOTIZATION_TOKEN);
  }
}