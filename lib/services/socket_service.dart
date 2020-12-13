import 'package:flutter/material.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token},
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket.disconnect();
  }
}
