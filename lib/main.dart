import 'package:band_names/src/pages/home.dart';
import 'package:band_names/src/pages/status.dart';
import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => SocketService(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'status': (context) => StatusPage(),
        },
      ),
    );
  }
}
