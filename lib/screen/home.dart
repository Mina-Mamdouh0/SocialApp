
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';


import 'package:social_app/screen/mainscreen/add_post_screen.dart';
import 'package:social_app/shared/companet.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context, state){
          var cubit=SocialCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
              title: Text(cubit.screenName[cubit.currentIndex],
              style: TextStyle(
                color: Colors.grey.shade900,
                fontWeight: FontWeight.bold,
                fontSize: 20
              )),
              elevation: 0.0,
              actions: [
                IconButton(onPressed: (){},
                    icon: const Icon(IconlyLight.notification)),
                IconButton(onPressed: (){},
                    icon: const Icon(IconlyLight.search)),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeIndexBottom(index);
              },
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon:Icon( IconlyLight.home,),label: 'Home'),
                BottomNavigationBarItem(icon:Icon( IconlyLight.message),label: 'Chats'),
                BottomNavigationBarItem(icon:Icon( IconlyLight.image_2),label: 'Add Post'),
                BottomNavigationBarItem(icon:Icon( IconlyLight.user_1),label: 'Users'),
                BottomNavigationBarItem(icon:Icon( IconlyLight.setting),label: 'Settings'),
              ],
            ),
          );
        },
        listener: (context, state){
          if(state is PostScreenState){
            navigatorPush(widget: AddPostScreen(),context: context);
          }

        });
  }
}
