import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double alto = 600;
  double ancho = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Expanded(
              child: Container(
              height:alto,
              width: ancho,
              child:FlareActor(
                  'assets/WATSON2.flr',
                  alignment: Alignment.center ,
                  fit: BoxFit.contain, 
                  animation: 'chef',
                ), 
            ),
          ),
          
          Center(
            child: SizedBox(
              width: 500.0,
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
          ),

          Divider(height: 100.0)

        ],
      ),


    );
  }//build
  

}//_SplashScreenState