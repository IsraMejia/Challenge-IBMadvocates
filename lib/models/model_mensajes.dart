import 'dart:convert';

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
}