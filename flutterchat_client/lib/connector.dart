import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model.dart';

class Connector {
  String serverURL = "http://192.168.1.10";
  late IO.Socket _io;

  void showPleaseWait() {
    showDialog(
      context: model.rootBuildContext,
      barrierDismissible: false,
      builder: (BuildContext inDialogContext) {
        return Dialog(
          child: Container(
            width: 150,
            height: 150,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(color: Colors.blue[200]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      value: null,
                      strokeWidth: 10,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Please wait, contacting server...',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void hidePleaseWait(){
    Navigator.of(model.rootBuildContext).pop();
  }

  void connectToServer(){
    _io = IO.io('http://$serverURL:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .build());
  }
}
