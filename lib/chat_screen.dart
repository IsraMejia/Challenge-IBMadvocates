import 'package:flutter/material.dart';
import 'package:watson_chef/mensajes.dart';
import 'package:watson_chef/models/model_mensajes.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}//ChatScreen

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {

  final List<Mensajes> _mensajes = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _ocultaTeclado = new FocusNode();

  WatsonCredencial credencial = WatsonCredencial(
     username     : "Dialogo de introducción",
     apikey       : "h4qjTYIE2uNnnTYIGfgDQkF7spj8bXr21TBjvlzW6f8t",
     version      : "2020-07-10",
     url          : "https://api.us-south.assistant.watson.cloud.ibm.com/instances/4e3162d6-993e-47c0-89ba-63f55655ad34/v1/workspaces/2c87464b-a78f-421e-9d48-bd934b62f439/message",
     assistantId  : "2c87464b-a78f-421e-9d48-bd934b62f439",
  );

  WatsonAssistantProvider watsonAssistantProvider;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext = WatsonAssistantContext(context: {});

  void initState() {
    super.initState();
    watsonAssistantProvider =
        WatsonAssistantProvider( watsonCredencial : credencial);
    _watsonContesta("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
    return Container(
      decoration: BoxDecoration( color: Color.fromRGBO(43, 126, 214, 0.7) ),
      child: IconTheme(
        data: IconThemeData(color: Colors.lightBlue[50] ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          // decoration: BoxDecoration( color: Colors.blue[700] ),
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
      ),
    );
  } //_crearTeclado

    String tipo= "watson"; //  "watson"    "watsonReceta"  "usuario"
    //tipo.contains(.); //para sabeque es watsonReceta "watsonReceta" ;
    String urlImagen = "https://t1.rg.ltmcdn.com/es/images/2/3/0/img_pollo_con_mole_9032_600.jpg";
    String urlyoutube = "https://www.youtube.com/watch?v=NXGWW8W3mss";
  
  void _enviar(String text ) {
    tipo= "usuario";
    _textController.clear();
    print(text);
    if(text.length == 0) {
      return null;
    }
    //Para intercalar entre tipos de mensajes en pruebas


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
    tipo= "watson";
    _watsonContesta(text);
 }//_enviar()


  void _watsonContesta(String text)async{
     tipo= "watson";
     watsonAssistantResponse = await watsonAssistantProvider.sendMessage(
     text , watsonAssistantContext);
     
     if( watsonAssistantResponse.resultText.contains("*")){
       tipo = "watsonReceta";
     }

      //Aqui agregar lo del URL de youtube para que el constructor de mensaje lo reciba 
      //igual intentare que reciba la miniatura para la url de la imagen ;D

    final animacionMensajes = new AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
    );

    Mensajes mensaje = new Mensajes(
      tipoMensaje: tipo,
      text: watsonAssistantResponse.resultText,
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
    watsonAssistantContext = watsonAssistantResponse.context;
    tipo= "usuario";
  }


  @override
  void dispose() { //Para Optimizar la memoria
    for (Mensajes mensaje in _mensajes)
      mensaje.animationController.dispose();
    super.dispose();
  }//dispose

} //_ChatScreenState
