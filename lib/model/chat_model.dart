import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  final String message;
  final String senderId;
  final String resendId;
  final Timestamp dateTime;

  ChatModel({required this.message,required this.senderId,required this.resendId,required this.dateTime});

  factory ChatModel.formJson(Map<String, dynamic> json,){
    return ChatModel(
      message: json['Message'],
      senderId:json['SenderId'],
      resendId: json['ResendId'],
      dateTime: json['DateTime'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Message': message,
      'SenderId':senderId,
      'ResendId': resendId,
      'DateTime': dateTime,
    };

  }
}