
import 'package:hi_net/request/hi_base_request.dart';

import 'package:gohub/http/dao/login_dao.dart';

abstract class BaseRequest extends HiBaseRequest{
  @override
  String url(){
    if(needLogin()){
      addHeader(LoginDao.AUTHOTIZATION_TOKEN ,'Bearer '+LoginDao.getToken());
    }
    return super.url();
  }
}