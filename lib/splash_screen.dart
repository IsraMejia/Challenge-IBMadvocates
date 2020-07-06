import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Divider(color: Colors.blue[900]),
          Container(
            height: 200,
            width: 200,
            child: FlareActor(
              'assets/food.flr',
              alignment: Alignment.center ,
              fit: BoxFit.contain,
              animation: 'Untitled',
            ),
          ),
          // Text('IBM Chatbot', style: TextStyle(fontSize: 25, color: Colors.blueGrey[50]) ),   
          Divider(height: 30.0),
          Center(
            child: SizedBox(
              width: 300.0,
              child: TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 200),
                totalRepeatCount: 1,
                onFinished: () => Navigator.pushReplacementNamed(context, 'chatScreen'),                                
                text: [
                  "Watson Chef"
                ],
                textStyle: TextStyle(
                    fontSize: 30.0, color: Colors.blueGrey[50]
                ),
                textAlign: TextAlign.center ,
                alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
            ),
          )

        ],
      ),


    );
  }//build
  

}//_SplashScreenState