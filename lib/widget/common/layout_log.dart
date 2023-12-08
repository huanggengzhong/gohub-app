import 'package:flutter/material.dart';
// 打印父组件约束性信息组件
//使用:LayoutLogPrint(child:Text("xx"))
//案例: 可以用例查看滚动父组件约束,  https://book.flutterchina.club/chapter6/listview.html#_6-3-4-%E5%9B%BA%E5%AE%9A%E9%AB%98%E5%BA%A6%E5%88%97%E8%A1%A8, 搜"固定高度列表"
class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
