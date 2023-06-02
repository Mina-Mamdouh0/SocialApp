import 'package:flutter/material.dart';
import '../model/chat_model.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat({
    Key? key,required this.message,
  }) : super(key: key);
  final ChatModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:const EdgeInsets.all(12),
        margin:const EdgeInsets.symmetric(
            vertical: 8,horizontal: 12
        ),
        decoration:const  BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )
        ),
        child: Text(message.message,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),),
      ),
    );
  }
}

class BubbleChatFormFriend extends StatelessWidget {
  BubbleChatFormFriend({
    Key? key, required this.message,
  }) : super(key: key);
  final ChatModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 12
        ),
        decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            )
        ),
        child: Text(message.message,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 15,
          ),),
      ),
    );
  }
}