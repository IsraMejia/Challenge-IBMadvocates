import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

 // true = watson,  false usuari

class Mensajes extends StatelessWidget {
  //Declaraciones y constructor
  Mensajes({
    this.tipoMensaje,
    this.text,
    this.animationController,
    this.urlImage,
    this.urlVideo,
  });/*
  CREA VARIOS CONSTRUCTORES Y YA ES MAS FACIL *ya se hizo y no jalo xd
  */ 

  // Mensajes.receta({
  //   this.tipoMensaje,
  //   this.text,
  //   this.urlImage,
  //   this.urlVideo,
  //   this.animationController,
  // });
  
  String tipoMensaje  ;
  String text;
  String urlImage ; //"https://t1.rg.ltmcdn.com/es/images/2/3/0/img_pollo_con_mole_9032_600.jpg";
  String urlVideo ; //"https://www.youtube.com/watch?v=NXGWW8W3mss";
  final AnimationController animationController;
  


  //Listas de Mensajes

  Widget  mensajesWatson( BuildContext context , String tipoMensaje , double anchoPantalla ){  
      return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container( 
                //   width: 25.0, height: 25.0,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(25.0))
                //   ),
                //   child: Image.asset('assets/watsonIcon.png', width: 25.0, height: 25.0 , fit: BoxFit.cover,) ,
                // ),
                // Text("hola"),
                Container(
                  margin: EdgeInsets.only(right : 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40.0),
                    child: Image.asset( 'assets/watsonIcon.png',
                        width: 52.0,
                        height: 52.0,
                        fit: BoxFit.fill,
                    ),
                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(text , 
                        style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                        ),
                      ), 
                      mostrarPlatillo(tipoMensaje , anchoPantalla) 
                      ],
                      ),
                    ), 
                  ],
                  ),
                ],
            ),
          );
  }//mensajesWatson




  //metodos necesarios  mensajesWatson
  // AnimationController animationController;
  Future<void> _abrirVideo;

  Future<void> _abrirVideoNavegador(String urlVideo) async{
    if(await canLaunch(urlVideo)){
      await launch(urlVideo);
    }else{
      throw "No se pudo abrir :c";
    }
  }

  Widget mostrarPlatillo(String tipoMensaje , double anchoPantalla){
    // tipoMensaje = "usuario";
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
               image:  NetworkImage(urlImage)
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

  



  Widget  mensajeUsuario( BuildContext context , String tipoMensaje , double anchoPantalla ){
    tipoMensaje = (tipoMensaje == "watsonReceta") ? "watson" : "watsonReceta";

    return  Row(
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
          ); 
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
          child: decideMensaje(context , tipoMensaje , anchoPantalla),
      ),

      


    );
  } //Mensajes 
  
  
  Widget decideMensaje(BuildContext context , String tipoMensaje , double anchoPantalla){
    switch (tipoMensaje) {
      case "watsonReceta":
        return mensajesWatson(context , tipoMensaje , anchoPantalla );
      break;

      case "watson":
        return mensajesWatson(context , tipoMensaje , anchoPantalla );
      break;

      case "usuario":
        return mensajeUsuario(context , tipoMensaje , anchoPantalla );
      break;

      default: return mensajesWatson(context , tipoMensaje , anchoPantalla );
    }
    
  }


}//Mensajes StatelessW

 