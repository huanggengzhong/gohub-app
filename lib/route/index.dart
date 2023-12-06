
import 'package:flutter/material.dart';
import 'package:gohub/page/home/home.dart';
import 'package:gohub/page/favorite/index.dart';
import 'package:gohub/route/navigator.dart';
import 'package:gohub/route/bottom_navigator.dart';
import 'package:hi_net/hi_net.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:gohub/http/dao/login_dao.dart';
import 'package:gohub/page/login/login.dart';

import '../page/favorite/index.dart';
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    //实现路由跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
          _routeStatus = routeStatus;
          // if (routeStatus == RouteStatus.detail) {
          //   this.videoModel = args!['videoMo'];
          // }
          notifyListeners();
        }));
    //设置网络错误拦截器
    HiNet.getInstance().setErrorInterceptor((error) {
      if (error is NeedLogin) {
        //清空失效的登录令牌
        HiCache.getInstance().remove(LoginDao.AUTHOTIZATION_TOKEN);
        //拉起登录
        HiNavigator.getInstance().onJumpTo(RouteStatus.login);
      }
    });
  }

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  // VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    // todo 这里依次填写自己路由
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其它页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }else if(routeStatus==RouteStatus.favorite){
      page=pageWrap(FavoritePage());
    }
    //重新创建一个数组，否则pages因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    //通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages;
    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
      !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                // showWarnToast("请先登录");
                return false;
              }
            }
          }
          //执行返回操作
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast();
          //通知路由发生变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    //测试
    return _routeStatus;//解决本地模拟无法跳转页面问题
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getToken() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath path) async {}
}

///定义路由数据，path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  // BiliRoutePath.detail() : location = "/detail";
}
