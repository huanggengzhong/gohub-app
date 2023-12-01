import 'package:gohub/page/home/home.dart';
import 'package:gohub/page/login/login.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: <String,WidgetBuilder>{
        "/home":(context) => const MyHomePage(title: 'Flutter Demo Home Page444'),
        "/login":(context)=>const LoginPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page444'),
    );
  }
}

