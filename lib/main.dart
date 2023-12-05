import 'package:gohub/page/home/home.dart';
import 'package:gohub/page/login/login.dart';
import 'package:flutter/material.dart';
import 'package:gohub/provider/theme_provider.dart';
import 'package:gohub/utils/defend.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:provider/provider.dart';
import 'provider/provider.dart';
import 'package:gohub/route/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  Defend().run(MyApp());
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        //初始化缓存配置
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          return MultiProvider(
              providers: topProviders,
              child: Consumer<ThemeProvider>(builder: (BuildContext context,
                  ThemeProvider themeProvider, Widget? child) {
                //定义路由
                var widget = snapshot.connectionState == ConnectionState.done
                    ? Router(routerDelegate: _routeDelegate)
                    : Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                //填入设计稿中设备的屏幕尺寸,单位dp
                return ScreenUtilInit(
                    designSize: const Size(375, 667),//默认iphone8参考
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) {
                      return MaterialApp(
                        home: widget,
                        theme: themeProvider.getTheme(),
                        darkTheme: themeProvider.getTheme(isDarkMode: true),
                        themeMode: themeProvider.getThemeMode(),
                        title: 'go hub',
                      );
                    });
              }));
        });
  }
}
