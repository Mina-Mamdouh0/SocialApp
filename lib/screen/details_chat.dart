
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/shared/chat_bubble.dart';

class DetailsChat extends StatelessWidget {
  final String name;
  final String userId;

  DetailsChat({Key? key, required this.name, required this.userId,}) : super(key: key);
  ScrollController scrollController=ScrollController();
  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      bloc: SocialCubit.get(context)..getMessage(resendId: userId),
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
               foregroundColor: Colors.grey,
                backgroundColor: Colors.white,
                title: Text(name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        reverse: true,
                        itemCount: cubit.chats.length,
                        itemBuilder: (context,index){
                          return  cubit.chats[index].senderId==cubit.userId?
                          BubbleChat(message: cubit.chats[index],):
                          BubbleChatFormFriend(message: cubit.chats[index],);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller:controller ,
                      decoration:  InputDecoration(
                        hintText: 'Message',
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        suffixIcon: InkWell(
                          onTap: (){
                            cubit.sendMessage(resendId: userId, message: controller.text);
                            scrollController.animateTo(
                              0,
                              duration:const Duration(milliseconds: 400),
                              curve: Curves.ease,
                            );
                            controller.clear();
                          },
                          child: const Icon(Icons.send,
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder:  const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 2
                            )
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 1
                            )
                        ),
                      ),
                      onSubmitted: (date){
                        cubit.sendMessage(resendId: userId, message: controller.text);
                        scrollController.animateTo(
                          0,
                          duration:const Duration(milliseconds: 400),
                          curve: Curves.ease,
                        );
                        controller.clear();
                      },
                    ),
                  ),
                ],
              )
          );
        },
        listener: (context,state){});
  }
}

/*
StreamBuilder<QuerySnapshot>(
stream: message.orderBy('created',descending: true).snapshots(),
builder: (context,snapshot){
if(snapshot.hasData){

return
}
else{
return const CircularProgressIndicator();
}
});*/
