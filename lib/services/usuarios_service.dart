import 'package:flutter_chat/global/enviroment.dart';
import 'package:flutter_chat/models/usuario.dart';
import 'package:flutter_chat/models/usuarios_response.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.http(Environment.apiUrl, '/api/usuarios'),
          headers: {'x-token': await AuthService.getToken()});
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
