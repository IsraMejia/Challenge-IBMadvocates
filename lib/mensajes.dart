import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

 // true = watson,  false usuari

class Mensajes extends StatelessWidget {
  //Declaraciones y constructor
  Mensajes({
    this.tipoMensaje,
    this.text,
    this.pathImage,
    this.urlVideo,
    this.context,
  });
  BuildContext context;
  String tipoMensaje = "watson" ;
  String text;
  String pathImage = "https://t1.rg.ltmcdn.com/es/images/2/3/0/img_pollo_con_mole_9032_600.jpg";
  String urlVideo = "https://www.youtube.com/watch?v=NXGWW8W3mss";
  double anchoPantalla = MediaQuery.of(context).size.width;

  //Listas de Mensajes
  Widget  mensajesWatson( BuildContext context , String tipoMensaje){
    
      return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container( //Avatar Watson
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar( 
                  backgroundImage:  NetworkImage("https://cdn.pixabay.com/photo/2019/07/25/20/13/robot-4363354_1280.png"),
                  radius: 25.0,
                  )
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Watson:", 
                      style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                      )
                    ),
                      
                    Container(
                      width: anchoPantalla * 0.65 , 
                      //Para que no se desborden los Mensajes y se acomoda solito en renglones
                      margin: EdgeInsets.only(top: 5.0),
                      child: Column(
                      children: <Widget>[
                        Text(text , 
                        style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                        ),
                      ), 
                      mostrarPlatillo(tipoMensaje) 
                      ],
                      ),
                    ), 
                  ],
                  ),
                ],
            ),
          );
  }




  //metodos necesarios
  AnimationController animationController;
  Future<void> _abrirVideo;

  Future<void> _abrirVideoNavegador(String urlVideo) async{
    if(await canLaunch(urlVideo)){
      await launch(urlVideo);
    }else{
      throw "No se pudo abrir :c";
    }
  }

  Widget mostrarPlatillo(String tipoMensaje){
    if (tipoMensaje == "watsonReceta"){
      return Stack(
        children: <Widget>[
        Container(
          width: anchoPantalla * 0.60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
             child: Image(
               width: anchoPantalla * 0.60,
               fit: BoxFit.cover,
               image:  NetworkImage(pathImage)
              ),
            ),
        ),
                            
        Container(
          margin: EdgeInsets.only(top: anchoPantalla * 0.35 , left: anchoPantalla * 0.15),
          child: RaisedButton(
            onPressed: (){
              _abrirVideoNavegador(urlVideo);
            } ,
            elevation: 9.0,
            color: Color.fromRGBO(78, 204, 223, .87) ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)
              ),
              child: Text("Ver Tutorial",
                style: TextStyle( fontSize: 18.0, color: Colors.blueGrey[900]),
                ),      
          ),
        ),
        ],
      );    
    }
    
    return Divider(); 
    //Si no se debe mostrar la receta solo retorna un widget Divider()
  }

  



  //build
  @override
  Widget build( BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo ),
      axisAlignment: 0.0,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: decideMensaje(context , tipoMensaje),
      ),

      


    );
  } //Mensajes 
  
  
  Widget decideMensaje(BuildContext context , String tipoMensaje){
    switch (tipoMensaje) {
      case "watsonReceta":
        return mensajesWatson(context , tipoMensaje);
      break;

      case "watson":
        return mensajesWatson(context , tipoMensaje);
      break;

      case "Usuario":
        return mensajesWatson(context , tipoMensaje);
      break;

      default: return Divider(height: 1.0);
    }
    
  }


}//Mensajes StatelessW









/*
class WatsonMensaje extends StatelessWidget {
  WatsonMensaje({this.text, this.animationController, this.});
  final String text;
  final AnimationController animationController;
  String pathImage = "https://t1.rg.ltmcdn.com/es/images/2/3/0/img_pollo_con_mole_9032_600.jpg";
  String urlVideo = "https://www.youtube.com/watch?v=NXGWW8W3mss";
  






  Future<void> _abrirVideo;

  Future<void> _abrirVideoNavegador(String urlVideo) async{
    if(await canLaunch(urlVideo)){
      await launch(urlVideo);
    }else{
      throw "No se pudo abrir :c";
    }
  }

  Widget mostrarPlatillo(String tipoMensaje){
    if (tipoMensaje == "watsonReceta"){
      return Stack(
        children: <Widget>[
        Container(
          width: anchoPantalla * 0.60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
             child: Image(
               width: anchoPantalla * 0.60,
               fit: BoxFit.cover,
               image:  NetworkImage(pathImage)
              ),
            ),
        ),
                            
        Container(
          margin: EdgeInsets.only(top: anchoPantalla * 0.35 , left: anchoPantalla * 0.15),
          child: RaisedButton(
            onPressed: (){
              _abrirVideoNavegador(urlVideo);
            } ,
            elevation: 9.0,
            color: Color.fromRGBO(78, 204, 223, .87) ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0)
              ),
              child: Text("Ver Tutorial",
                style: TextStyle( fontSize: 18.0, color: Colors.blueGrey[900]),
                ),      
          ),
        ),
        ],
      );    
    }
    return Divider();
  }




  @override
  Widget build(BuildContext context) {
  double anchoPantalla = MediaQuery.of(context).size.width;
    
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo ),
      axisAlignment: 0.0,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container( //Avatar Watson
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar( 
                  backgroundImage:  NetworkImage("https://cdn.pixabay.com/photo/2019/07/25/20/13/robot-4363354_1280.png"),
                  radius: 25.0,
                )
              ),
              
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: <Widget>[
                  Text("Watson:", style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                      )
                  ),
                  Container(
                    width: anchoPantalla * 0.65 , 
                    //Para que no se desborden los Mensajes y se acomoda solito en renglones
                    margin: EdgeInsets.only(top: 5.0),
                    child: Column(
                      
                      children: <Widget>[
                        Text(text , 
                        style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                        ),
                        ), 
                        mostrarPlatillo(tipoMensaje) 
                      ],
                    ),
                  ),
                
                ],


              ),
            ],
          )
      ),
    ); //SizeTtansition WatsonMensaje
  }// build
} //Class WatsonMensaje

*/


class UsuarioMensaje extends StatelessWidget {
  UsuarioMensaje({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOutExpo ),
      axisAlignment: 0.0,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             Column( 
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric( horizontal: 21.0),
                    width: anchoPantalla * 0.8 , 
                    //Para que no se desborden los Mensajes y se acomoda solito en renglones
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text , 
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              Container(    
                // margin: const EdgeInsets.only(right: 0.0),
               child: CircleAvatar(child: Text("Tú") , radius: 25.0),
              )
            ],
          )),
    );
  }// build
} //Class UsuarioMensaje


