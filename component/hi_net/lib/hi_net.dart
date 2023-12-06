import 'package:hi_net/core/dio_adapter.dart';
import 'package:hi_net/request/hi_base_request.dart';

import 'core/hi_error.dart';
import 'core/hi_interceptor.dart';
import 'core/hi_net_adapter.dart';

///1.支持网络库插拔设计，且不干扰业务层
///2.基于配置请求请求，简洁易用
///3.Adapter设计，扩展性强
///4.统一异常和返回处理
class HiNet {
  HiNet._();

  HiErrorInterceptor? _hiErrorInterceptor;
  static HiNet? _instance;

  static HiNet getInstance() {
    if (_instance == null) {
      _instance = HiNet._();
    }
    return _instance!;
  }

  Future fire(HiBaseRequest request) async {

    String path=request.url();
    // print("-----请求头-----");
    // print(request.header);

    var params=request?.params;

    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(path,params,e.message);
    } catch (e) {
      //其它异常
      error = e;
      printLog(path,params,e);
    }
    if (response == null) {
      printLog(path,params,error);
    }
    var result = response?.data;
    printLog(path,params,result);
    var status = response?.statusCode;
    var hiError;
    switch (status) {
      case 200:
        return result;
        case 201:
        return result;
      case 401:
        hiError = NeedLogin();
        break;
      case 403:
        hiError = NeedAuth(result.toString(), data: result);
        break;
      case 422:
        return result;

      default:
        //如果error不为空，则复用现有的error
        hiError =
            error ?? HiNetError(status ?? -1, result.toString(), data: result);
        break;
    }
    //交给拦截器处理错误
    if (_hiErrorInterceptor != null) {
      _hiErrorInterceptor!(hiError);
    }
    throw hiError;
  }

  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) async {
    ///使用Dio发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void setErrorInterceptor(HiErrorInterceptor interceptor) {
    this._hiErrorInterceptor = interceptor;
  }

  void printLog(path,params,log) {
    print('请求地址:$path,请求参数:$params,请求结果:' + log.toString());
  }
}
