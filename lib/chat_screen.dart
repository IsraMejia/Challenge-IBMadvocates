import 'package:flutter/material.dart';
String _watson ="Watson";
bool origen = true ; // true = watson,  false usuario

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}//ChatScreen

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<WatsonMensaje> _mensajes = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _ocultaTeclado = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Watson Chef 👨🏽‍🍳', 
          style: TextStyle(color: Colors.blueGrey[50], fontSize: 22.0),
        )
      ),
      body:  GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          FocusScope.of(context).requestFocus(_ocultaTeclado);
        },//Se encarga de esconder el teclado cuando se toca fuera de él

        child :Stack(
        children: <Widget>[
          _fondoChat(),
          Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _mensajes[index],
                itemCount: _mensajes.length,
              ),
            ),
            Divider(height: 3.0),
            Container(
              child: _crearTeclado(),
            ),
          ],
        ),
      
      ],      
      ),
      ),
                
    );
  }//build

  Widget _fondoChat(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.05),
          end: FractionalOffset(0.0, .7),
          colors: [
            Colors.blue[900],
            Colors.blue[800]
          ]
        )
      ),
    );
  }

  Widget _crearTeclado() {
    return IconTheme(
      data: IconThemeData(color: Colors.lightBlue[50] ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(//Teclado
                
                style: TextStyle(fontSize: 20.0, color: Colors.blue[50]),
                cursorColor: Colors.blueGrey[200] ,
                controller: _textController,
                onSubmitted: _enviar,
                decoration:
                  InputDecoration.collapsed(
                    hintText: 'Hablemos de cocina :)' ,
                    hintStyle: TextStyle(fontSize: 19.0, color: Colors.blueAccent[50]) ,
                    fillColor:Colors.white ),
                focusNode: _focusNode,
                
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if(_textController.text.length == 0) {
                      print('vacio');
                    } else{
                      _enviar(_textController.text);
                    }
                  } 
                  //Arreglar para que no mande mensajes vacios
              ) ,
            )
          ],
        ),
      ),
    );
  } //_crearTeclado

  void _enviar(String text) {
    _textController.clear();
    print(text.length);
      WatsonMensaje mensaje = WatsonMensaje(
        text: text,
        animationController: AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        ),
      );
      setState(() {
        _mensajes.insert(0, mensaje);
      });
      _focusNode.requestFocus();
      mensaje.animationController.forward();
      

    

  } //_enviar

  @override
  void dispose() { //Para Optimizar la memoria
    for (WatsonMensaje mensaje in _mensajes)
      mensaje.animationController.dispose();
    super.dispose();
  }//dispose

} //_ChatScreenState


class WatsonMensaje extends StatelessWidget {
  WatsonMensaje({this.text, this.animationController});
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
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                
                margin: const EdgeInsets.only(right: 16.0),
                // child: CircleAvatar(child: Text(_watson[0])),

                child: CircleAvatar( 
                  backgroundImage:  NetworkImage("https://cdn.pixabay.com/photo/2019/07/25/20/13/robot-4363354_1280.png"),
                  radius: 25.0,
                  
                )

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_watson, style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                        
                    )),
                  Container(
                    width: anchoPantalla * 0.65 , 
                    //Para que no se desborden los mensajes y se acomoda solito en renglones
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text , style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                    ),),
                  ),
                ],
              ),
            ],
          )),
    );
  }// build
} //Class WatsonMensaje

//


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
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                
                margin: const EdgeInsets.only(right: 16.0),
               child: CircleAvatar(child: Text("Tú") , radius: 25.0),

              
              ),
              Column( 
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tú", style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                        
                    )),
                  Container(
                    width: anchoPantalla * 0.65 , 
                    //Para que no se desborden los mensajes y se acomoda solito en renglones
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      text , style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.blueGrey[50]
                    ),),
                  ),
                ],
              ),
            ],
          )),
    );
  }// build
} //Class UsuarioMensaje



