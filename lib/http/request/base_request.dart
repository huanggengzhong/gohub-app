
import 'package:hi_net/request/hi_base_request.dart';

abstract class BaseRequest extends HiBaseRequest{
  @override
  String url(){
    if(needLogin()){
      addHeader("Authorization", "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMTIiLCJ1c2VyX25hbWUiOiJnZW5nemhvbmcxMCIsImV4cGlyZV90aW1lIjoxNzA1MzkzMTA3LCJleHAiOjE3MDUzOTMxMDcsImlhdCI6MTcwMDIwOTEwNywiaXNzIjoiR29odWIiLCJuYmYiOjE3MDAyMDkxMDd9.Rp_I8CntY2SuStl219e04JPY4gWuZ1QjVCagBFnFmAA");
    }
    return super.url();
  }
}