import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() => runApp(FlutterChat());

class FlutterChat extends StatelessWidget {
  @override
  Widget build(_) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('server test', style: TextStyle(fontSize: 69, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
