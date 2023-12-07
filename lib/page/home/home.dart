
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gohub/http/dao/home_dao.dart';
import 'package:gohub/route/navigator.dart';
import 'package:gohub/utils/view.dart';
import 'package:gohub/widget/common/hi_tab.dart';
import 'package:gohub/widget/common/loading_container.dart';
import 'package:gohub/widget/common/navigation_bar.dart';
import 'package:gohub/model/home/category_home.dart' as CategoryMo;

import 'package:gohub/utils/toast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin,WidgetsBindingObserver {
  bool _isLoading = true;
  List<CategoryMo.Data> categoryList = [];
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    loadData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  ///监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(':didChangeAppLifecycleState:$state');
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
      print("从后台切换前台");
      //fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        print("界面不可见，后台");
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
          isLoading: _isLoading,
          child: Column(
            children: [
              NavigationBarPlus(
                height: 50.h,
                child: _appBar(),
                color: Colors.white,
                statusStyle: StatusStyle.DARK_CONTENT,
              ),
              Container(
                decoration: bottomBoxShadow(context),
                child: _tabBar(),
              ),
              Flexible(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    Text("haha1"),
                    Text("haha2"),
                    Text("haha3"),
                    Text("haha4"),
                    Text("haha5"),
                    Text("haha6"),
                  ],
                ),
              ),
              // Column(
              //     children: categoryList.map((e) {
              //   return Text(e.name!);
              // }).toList()),
              ElevatedButton(
                child: Text('登录页面'),
                onPressed: () {
                  HiNavigator.getInstance().onJumpTo(RouteStatus.login);
                },
              ),
              ElevatedButton(
                child: Text('视频页面'),
                onPressed: () {
                  HiNavigator.getInstance().onJumpTo(RouteStatus.video);
                },
              ),
            ],
          )),
    );
  }

  //获取数据
  loadData() async {
    var w = await HomeDao.getCategorys();
    var res = CategoryMo.CategoryModel.fromJson(w);
    if (res.code != 200) {
      $Toast.show(res.message!);
      return;
    }
    if (res.data != null) {
      //tab长度变化后需要重新创建TabController
      _controller = TabController(length: res.data?.length ?? 0, vsync: this);
    }
    setState(() {
      categoryList = res.data??[];
      _isLoading = false;
    });
  }

  //分类导航
  _tabBar() {
    return HiTab(
      categoryList.map((e) {
        return Tab(
          text: e.name,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  //自定义顶部
  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15.r, right: 15.r),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23.w),
              child: Image(
                height: 46.w,
                width: 46.w,
                image: const AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15.r, right: 15.r),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.w),
                  child: InkWell(
                    onTap: () {
                      // print("点击搜索");
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10.r),
                      height: 32.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: const Icon(Icons.search, color: Colors.grey),
                    ),
                  )),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.view_headline,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
