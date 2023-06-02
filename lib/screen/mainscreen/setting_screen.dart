
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/model/signup_model.dart';
import 'package:social_app/screen/edit_profile_screen.dart';
import 'package:social_app/shared/companet.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<SocialCubit,SocialState>(
          builder: (context,state){
            SignUpModel userModel=SocialCubit.get(context).signUpModel!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 225,
                    child: Stack(
                      children: [
                        Container(
                          height: 175,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(userModel.cover)
                              )
                          ),
                        ),
                         Align(
                          alignment: Alignment.bottomCenter,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(userModel.profile),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                    Text(userModel.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),),
                  const SizedBox(height: 5,),
                    Text(userModel.bio,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.normal
                    ),),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:const  [
                              Text('100',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 5,),
                              Text('Posts',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal
                                ),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:const  [
                              Text('100',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 5,),
                              Text('Photo',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal
                                ),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:const  [
                              Text('100',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 5,),
                              Text('Follows',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal
                                ),),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:const  [
                              Text('100',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 5,),
                              Text('Followers',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: OutlinedButton(onPressed: (){},
                          child: const  Text('Add Photos',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.normal
                            ),),),
                      ),
                      const SizedBox(width: 5,),
                      OutlinedButton(onPressed: (){
                        navigatorPush(context: context,widget: EditProfileScreen());
                      },
                          child: const  Icon(IconlyLight.edit,
                            color: Colors.blue,)),
                    ],
                  )


                ],
              ),
            );
          },
          listener: (context,state){

          });
  }
}