import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gohub/http/dao/home_dao.dart';
import 'package:gohub/route/navigator.dart';
import 'package:gohub/widget/common/hi_tab.dart';
import 'package:gohub/widget/common/loading_container.dart';
import 'package:gohub/widget/common/navigation_bar.dart';

import 'package:gohub/model/home/category_home.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  bool _isLoading=false;
  List<CategoryModel> categoryList=[];
  late TabController _controller;


  @override
  void initState() {
    _controller = TabController(length: categoryList.length, vsync: this);
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
          child:Column(
            children: [
                NavigationBarPlus(
                  height: 50.h,
                  child: _appBar(),
                ),

              ElevatedButton(
                child: Text('登录页面'),
                onPressed: () {
                  HiNavigator.getInstance().onJumpTo(RouteStatus.login);
                },)
            ],
          )
      ),

    );

  }
  //获取数据
  loadData() async{
   var result= await HomeDao.getCategorys();
   setState(() {
     // categoryList=result["data"];
     categoryList=result;
     print(categoryList);
   });
  }
  //自定义顶部
  _appBar(){
    // return Text("haha");
    // return categoryList.map((e) => Tab(text:"haha"));
    return ListView.builder(
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("haha222"),
        );
      },
    );
    // return HiTab(
    //   categoryList.map<Tab>((tab) {
    //     return Tab(
    //       text: "hahh",
    //     );
    //   }).toList(),
    //   controller: _controller,
    //   fontSize: 16,
    //   borderWidth: 3,
    //   unselectedLabelColor: Colors.black54,
    //   insets: 13,
    // );
  }


}
