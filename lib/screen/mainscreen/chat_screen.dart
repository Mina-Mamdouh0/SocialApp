
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/model/signup_model.dart';
import 'package:social_app/screen/details_chat.dart';
import 'package:social_app/shared/companet.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          List<SignUpModel> usersList=cubit.usersDate;
          return ListView.separated(
              itemBuilder: (context,index){
                return cubit.userId!=usersList[index].uId?
                InkWell(
                  onTap: (){
                    navigatorPush(context: context,widget:DetailsChat(
                      userId: usersList[index].uId,
                    name: usersList[index].name,) );

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(usersList[index].profile),
                        ),
                        const SizedBox(width: 20,),
                        Text(usersList[index].name,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),),
                      ],
                    ),
                  ),
                ):Container();
              },
              separatorBuilder: (context,index){
                return const Divider();
              },
              itemCount: usersList.length);
        },
        listener: (context,state){

        });
  }
}