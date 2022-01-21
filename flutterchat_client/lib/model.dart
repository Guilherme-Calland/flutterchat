import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FlutterChatModel extends Model{
  late BuildContext rootBuildContext;
  late Directory docsDir;
  String greeting = "";
  String userName = "";
  static const String DEFAULT_ROOM_NAME = "Not currently in a room";
  String currentRoomName = DEFAULT_ROOM_NAME;
  List currentRoomUserList = [];
  bool currentRoomEnabled = false;
  List currentRoomMessages = [];
  List roomList = [];
  List usersList = [];
  bool creatorFunctionsEnabled = false;
  Map roomInvites = {};

  void setGreeting(final String inGreeting){
    greeting = inGreeting;
    notifyListeners();
  }

  void setUserName(final String inUserName){
    userName = inUserName;
    notifyListeners();
  }

  void setCurrentRoom(final String inCurrentRoomName){
    currentRoomName = inCurrentRoomName;
    notifyListeners();
  }

  void setCreatorFunctionsEnabled(){
    creatorFunctionsEnabled = true;
    notifyListeners();
  }

  void setCurrentRoomEnabled(){
    currentRoomEnabled = true;
    notifyListeners();
  }

  void addMessage(final String inUserName, final String inMessage) {
    currentRoomMessages.add(
        {"userName": inUserName, "message": inMessage});
    notifyListeners();
  }

  void setRoomList(final Map inRoomList){
    List rooms = [];
    for(String roomName in inRoomList.keys){
      Map r = inRoomList[roomName];
      rooms.add(r);
    }
    roomList = rooms;
    notifyListeners();
  }

  void setUserList(final Map inUserList){
    List users = [];
    for(String userName in inUserList.keys){
      Map u = inUserList[userName];
      users.add(u);
    }
    usersList = users;
    notifyListeners();
  }

  void setCurrentRoomUserList(Map inCurrentRoomUserList){
    List userList = [];
    for(String userName in inCurrentRoomUserList.keys){
      Map u = inCurrentRoomUserList[userName];
      userList.add(u);
    }
    currentRoomUserList = userList;
  }

  void addRoomInvite(final String inRoomName){
    roomInvites[inRoomName] = true;
  }

  void removeRoomInvite(final String inRoomName){
    roomInvites.remove(inRoomName);
  }

  void clearCurrentRoomMessaged(){
    currentRoomMessages = [];
  }
}

FlutterChatModel model = FlutterChatModel();






