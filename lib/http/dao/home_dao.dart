import 'package:gohub/http/request/home_request.dart';
import 'package:hi_net/hi_net.dart';
import 'dart:convert';
import 'package:gohub/model/home/category_home.dart';
class HomeDao {
  //https://api.devio.org/uapi/fa/home/推荐?pageIndex=1&pageSize=10
  static getCategorys( {String sort="",String order="",  String page = "", String per_page = ""}) async {
    HomeRequest request = HomeRequest();
    // request.pathParams = categoryName;
    // request.add("sort", sort).add("order", order).add("page", page).add("per_page", per_page);
    var result = await HiNet.getInstance().fire(request);
    return result;
    // return CategoryModel.fromJson(result);

  }
}