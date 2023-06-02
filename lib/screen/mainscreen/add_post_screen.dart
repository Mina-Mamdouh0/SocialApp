
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/shared/companet.dart';

class AddPostScreen extends StatelessWidget {
   AddPostScreen({Key? key}) : super(key: key);

  var postController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: mainAppBar(
                context: context,
                name: 'Create Post',
                action: [
                  (state is LoadingAddPost || state is LoadingPostWithImage)?
                      Container():
                      textButton(
                      text: 'Post',
                      onPress: (){
                        if(cubit.postImage==null){
                          if(postController.text.isNotEmpty){
                            cubit.addPost(post: postController.text);
                          }else{
                            showToast(msg: 'The post is empty', color: Colors.red);
                          }
                        }else{
                          cubit.addPostWithImage(post: postController.text);
                        }
                      }
                  )
                ]
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  (state is LoadingAddPost || state is LoadingPostWithImage)?
                  const LinearProgressIndicator():Container(),
                  (state is LoadingAddPost || state is LoadingPostWithImage)?
                  const SizedBox(height: 10,):Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(cubit.signUpModel!.profile),
                      ),
                      const SizedBox(width: 10,),
                       Expanded(
                        child: Text(cubit.signUpModel!.name,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                      child: TextFormField(
                    controller: postController,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'what is to mind...',
                      border: InputBorder.none
                      )
                      )
                    ),
                  (cubit.postImage!=null)?
                  Stack(
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
                                image: FileImage(cubit.postImage!)
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: (){
                            cubit.clearImagePost();
                          },
                          icon: Container(
                            height: 50,
                            width: 50,
                            decoration:const  BoxDecoration(
                                color: Colors.black38,
                                shape: BoxShape.circle
                            ),
                            child: const Center(
                              child: Icon(IconlyLight.close_square,
                                  size: 25,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      :Container(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child:InkWell(
                            onTap: (){
                              showDialogImages(
                                  context: context,
                                  camera: ()async{
                                    Navigator.pop(context);
                                    XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                    if(picked !=null){
                                      cubit.showImagePost(image: File(picked.path));
                                    }
                                  },
                                  gallery:()async{
                                    Navigator.pop(context);
                                    XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                    if(picked !=null){
                                      cubit.showImagePost(image: File(picked.path));
                                    }
                                  }
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconlyLight.camera,color: Colors.blue,),
                                SizedBox(width: 8,),
                                Text('Add Photo',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),)
                              ],
                            ),
                          ) ),
                      const SizedBox(width: 5,),
                      Expanded(
                          child:InkWell(
                            onTap: (){},
                            child:  const Center(
                              child: Text('# TAG',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                ),),
                            ),
                          ) ),
                    ],
                  ),
                  const SizedBox(height: 15,)

                ],
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessAddPost){
            postController.clear();
            SocialCubit.get(context).getPosts();
            Navigator.pop(context);
          }else if(state is SuccessPostWithImage){
            postController.clear();
            SocialCubit.get(context).postImage=null;
            SocialCubit.get(context).getPosts();
            Navigator.pop(context);
          }

        });
  }
}