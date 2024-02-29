import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus {
  online,
  offline,
  connecting,
}

class SocketService with ChangeNotifier {

  var _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;
  io.Socket get socket => _socket;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {

    _socket = io.io('http://192.168.100.4:3000', {
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });

  }

}
