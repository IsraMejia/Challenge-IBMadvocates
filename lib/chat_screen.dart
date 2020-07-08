import 'package:flutter/material.dart';
import 'package:watson_chef/mensajes.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}//ChatScreen

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<Mensajes> _mensajes = [];
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
                    hintStyle: TextStyle(fontSize: 19.0, color: Colors.blue[100] ) ,
                    fillColor:Colors.white ),
                focusNode: _focusNode,
                
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    
                       _enviar(_textController.text  );
                    
                  } 
                  //Arreglar para que no mande mensajes vacios
              ) ,
            )
          ],
        ),
      ),
    );
  } //_crearTeclado

  void _enviar(String text ) {
    _textController.clear();
    print(text);
    if(text.length == 0) {
      return null;
    }
    //Para intercalar entre tipos de mensajes en pruebas
    String tipo = "watsonReceta";
    String urlImagen = "https://t1.rg.ltmcdn.com/es/images/2/3/0/img_pollo_con_mole_9032_600.jpg";
    String urlyoutube = "https://www.youtube.com/watch?v=NXGWW8W3mss";

    final animacionMensajes = new AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
    );

    Mensajes mensaje = new Mensajes(
      tipoMensaje: tipo,
      text: text,
      animationController: animacionMensajes,
      urlImage : urlImagen,
      urlVideo : urlyoutube,
    );

    print(mensaje.tipoMensaje);
    setState(() {
     _mensajes.insert(0, mensaje);
    });

    _focusNode.requestFocus();
    mensaje.animationController.forward();  
  
 }//_enviar()



  @override
  void dispose() { //Para Optimizar la memoria
    for (Mensajes mensaje in _mensajes)
      mensaje.animationController.dispose();
    super.dispose();
  }//dispose

} //_ChatScreenState
