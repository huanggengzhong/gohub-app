import 'package:flutter/material.dart';
import 'package:gohub/route/navigator.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('登录页面'),
              onPressed: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.login);
              },
            ),
            ElevatedButton(
              child: Text('测试去喜欢页面'),
              onPressed: () {
                HiNavigator.getInstance().onJumpTo(RouteStatus.favorite);
              },
            )
          ],
        ),
      ),
    );
  }
}
