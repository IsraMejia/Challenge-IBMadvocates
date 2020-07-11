import 'dart:convert';
import 'package:http/http.dart' as http;  

Mensajes mensajesFromJson(String str) => Mensajes.fromJson(json.decode(str));

String mensajesToJson(Mensajes data) => json.encode(data.toJson());

class Mensajes {
    Mensajes({
        this.tipoMensaje,
        this.text,
        this.urlImage,
        this.urlVideo,
    });

    String tipoMensaje;
    String text;
    String urlImage;
    String urlVideo;

    factory Mensajes.fromJson(Map<String, dynamic> json) => Mensajes(
    //Que resa un factory permite retornar una nueva instancia del ProductoModel recibiendo un mapa
    //Esto permite asignar los valores a cada uno de sus propiedades
        tipoMensaje : json["tipoMensaje"],
        text        : json["text"],
        urlImage    : json["urlImage"],
        urlVideo    : json["urlVideo"],
    );

    Map<String, dynamic> toJson() => {
    //Mapa lo pasa a JSON, toma el mapa y lo pasa a JSON
        "tipoMensaje": tipoMensaje,
        "text"       : text,
        "urlImage"   : urlImage,
        "urlVideo"   : urlVideo,
    };
}//Mensajes Class


/*
  Skill details
Skill name:Dialogo de introducción
Skill ID:2c87464b-a78f-421e-9d48-bd934b62f439
Legacy v1 workspace URL:https://api.us-south.assistant.watson.cloud.ibm.com/instances/4e3162d6-993e-47c0-89ba-63f55655ad34/v1/workspaces/2c87464b-a78f-421e-9d48-bd934b62f439/message
Service credentials
Service credentials name:Auto-generated service credentials
API key:h4qjTYIE2uNnnTYIGfgDQkF7spj8bXr21TBjvlzW6f8t
 */

class WatsonAssistantResponse {
  String resultText;
  WatsonAssistantContext context;
  WatsonAssistantResponse({this.resultText, this.context});
}




class WatsonAssistantContext {
  Map<String, dynamic> context;

  WatsonAssistantContext({
    this.context,
  });

  void resetContext() {
    this.context = {};
  }
}



WatsonCredencial watsonCredencialFromJson(String str) => WatsonCredencial.fromJson(json.decode(str));

String watsonCredencialToJson(WatsonCredencial data) => json.encode(data.toJson());

class WatsonCredencial {
    WatsonCredencial({
        this.username,
        this.apikey,
        this.version,
        this.url,
        this.assistantId,
    }); //WatsonCredencial(

    String username = "Dialogo de introducción";
    String apikey = "h4qjTYIE2uNnnTYIGfgDQkF7spj8bXr21TBjvlzW6f8t";
    String version = "2020-07-10";
    String url = "https://api.us-south.assistant.watson.cloud.ibm.com/instances/4e3162d6-993e-47c0-89ba-63f55655ad34/v1/workspaces/2c87464b-a78f-421e-9d48-bd934b62f439/message";
    String assistantId = "2c87464b-a78f-421e-9d48-bd934b62f439";
    // String urlWatsonAssistant = "https://api.us-south.assistant.watson.cloud.ibm.com/instances/4e3162d6-993e-47c0-89ba-63f55655ad34/v1/workspaces/2c87464b-a78f-421e-9d48-bd934b62f439/message?version=2020-07-10";
    String authn ="Basic YXBpa2V5Omg0cWpUWUlFMnVObm5UWUlHZmdEUWtGN3NwajhiWHIyMVRCanZselc2Zjh0";

   
    factory WatsonCredencial.fromJson(Map<String, dynamic> json) => WatsonCredencial(
        username: json["username"],
        apikey: json["apikey"],
        version: json["version"],
        url: json["url"],
        assistantId: json["assistantID"],
    );//factory WatsonCredencial.fromJson

    Map<String, dynamic> toJson() => {
        "username": username,
        "apikey": apikey,
        "version": version,
        "url": url,
        "assistantID": assistantId,
    };// Map<String, dynamic> toJson()

}//class WatsonCredencial


class WatsonAssistantProvider {
  WatsonCredencial watsonCredencial;

  Future<WatsonAssistantResponse> sendMessage(
      String textInput, WatsonAssistantContext context) async {
    try {
      // String urlAssistant =watsonCredencial.urlWatsonAssistant;
      String autenAssistant = watsonCredencial.authn;

      Map<String, dynamic> _body = {
        "input": {"text": textInput},
        "context": context.context
      }; //El mapa del body para el JSON

      //Create a new session.
      // A session is used to send user input to a skill and receive responses.
      // It also maintains the state of the conversation.

      var nuevaSesion = await http.post(
          '${watsonCredencial.url}/assistants/${watsonCredencial.assistantId}/sessions?version=${watsonCredencial.version}',
          headers: {'Content-Type': 'application/json', 'Authorization': autenAssistant},
          body: json.encode(_body));
      try {
        if (nuevaSesion.statusCode != 201) {
          //throw Exception('Failed to load post');
          throw Exception('post error: statusCode= ${nuevaSesion.statusCode}');
        }
      } on Exception {
        print('Failed to load post');
        print(nuevaSesion.statusCode);
      } //Create a new session. A session is used to send user input to a skill and receive responses. It also maintains the state of the conversation.
      //Crea una nueva sesion si no hay ningun error



      print(nuevaSesion.body);
      var parsedJsonSession = json.decode(nuevaSesion.body);
      String session_id = parsedJsonSession['session_id'];
      /* print('the session $session_id is created');*/

      var receivedText = await http.post(
        '${watsonCredencial.url}/assistants/${watsonCredencial.assistantId}/sessions/$session_id/message?version=${watsonCredencial.version}',
        headers: {'Content-Type': 'application/json', 'Authorization': autenAssistant},
        body: json.encode(_body), //Recive el body del json
        //body: data
      );

      /* print(receivedText.statusCode);
      print(receivedText.body);*/

      var parsedJson = json.decode(receivedText.body);
      var _WatsonResponse = parsedJson['output']['generic'][0]['text']; //AQUI ESTA LA RESPUESTA

      Map<String, dynamic> _result = json.decode(receivedText.body);

      //print('this is result : $_result');
      WatsonAssistantContext _context =
          WatsonAssistantContext(context: _result['context']);

      WatsonAssistantResponse watsonAssistantResult = WatsonAssistantResponse(
          context: _context, resultText: _WatsonResponse);

      return watsonAssistantResult;


    }//Future<WatsonAssistantResponse> sendMessage(....async{try{



    catch (error) {
      //print(error);
      return error;
    }//catch

  }//Future<WatsonAssistantResponse> sendMessage(....async{...
}//class WatsonAssistantProvider
