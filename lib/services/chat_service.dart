import 'package:flutter/material.dart';
import 'package:flutter_chat/global/enviroment.dart';
import 'package:flutter_chat/models/mensajes_response.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final resp = await http.get(
        Uri.http(Environment.apiUrl, '/api/mensajes/$usuarioID'),
        headers: {'x-token': await AuthService.getToken()});

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
