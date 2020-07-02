import 'package:flutter/material.dart';

import 'package:watson_chef/splash_screen.dart';
import 'chat_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primaryColor: Colors.deepPurple[900],
      ),
      initialRoute: 'splashScreen',
      routes: {
        'splashScreen' : (BuildContext context) => SplashScreen(),
        'chatScreen'   : (BuildContext context) => ChatScreen(),
      },
    );
  }
}