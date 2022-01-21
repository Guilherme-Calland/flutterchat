import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main(){
  Socket socket = io('http://localhost:4000',
      OptionBuilder()
      .setTransports(['websocket'])
      .build());
  runApp(FlutterChat());

  socket.on('connection', (data){
    print(data);
  });
}

class FlutterChat extends StatelessWidget {
  @override
  Widget build(_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('server test', style: TextStyle(fontSize: 69, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
