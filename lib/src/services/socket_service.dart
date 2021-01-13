import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true
    });
    // IO.Socket socket = io(
    //     'http://10.0.2.2:3000',
    //     OptionBuilder()
    //         .setTransports(['websocket']) // for Flutter or Dart VM
    //         .disableAutoConnect() // disable auto-connection
    //         .setExtraHeaders({'foo': 'bar'}) // optional
    //         .build());
    // socket.io
    //   ..disconnect()
    //   ..connect();
    // socket.connect();

    this._socket.onConnect((_) {
      print('Connect ...');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      print('Disconnect ...');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('Nuevo mensaje :');
      print('nombre: ' + payload['nombre']);
      print(payload.conainsKey('mensaje')
          ? payload['mensaje']
          : 'no ha llegado msj');
      print(payload.conainsKey('mensaje2')
          ? payload['mensaje2']
          : 'no ha llegado msj2');
    });
  }
}
