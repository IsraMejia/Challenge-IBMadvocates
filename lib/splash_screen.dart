import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SplashScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget>[
          
          Divider(color: Colors.white),
          Container(
            height: 200,
            width: 200,
            child: FlareActor(
              'assets/food.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'Untitled',
            ),
          ),
          Text('IBM Chatbot'),          
        ],
      ),

      floatingActionButton: _botonStart(context),

    );
  }//build
  _botonStart(BuildContext context){
    return RaisedButton.icon(
      onPressed: () => Navigator.pushReplacementNamed(context, 'chatScreen'),
      label: Text('Start'),
      icon: Icon(Icons.chat),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple[500] ,
      textColor: Colors.blueGrey[50],
    );

  }

}//_SplashScreenState