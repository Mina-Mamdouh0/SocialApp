
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/model/signup_model.dart';
import 'package:social_app/shared/companet.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          SignUpModel userModel=SocialCubit.get(context).signUpModel!;

          return Scaffold(
            appBar: mainAppBar(
                context: context,
                name: 'Edit Profile',
                action: [
                  (state is LoadingUpdateUser)?
                      Container():
                  textButton(
                      text: 'Update',
                      onPress: (){
                        cubit.updateUserDate(
                            name: cubit.nameUpdate.text,
                            bio: cubit.bioUpdate.text,
                            phone: cubit.phoneUpdate.text );
                      }
                  )
                ]
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (state is LoadingUpdateUser)?
                    const LinearProgressIndicator():Container(),
                    SizedBox(
                      width: double.infinity,
                      height: 225,
                      child: Stack(
                       alignment: Alignment.bottomCenter,
                        children: [
                          Stack(
                            children: [
                              cubit.imageCover!=null?
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
                                        image: FileImage(cubit.imageCover!)
                                    )
                                ),
                              ):Container(
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
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: (){
                                    showDialogImages(
                                        context: context,
                                        camera: ()async{
                                          Navigator.pop(context);
                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                          if(picked !=null){
                                            cubit.changeCover(image: File(picked.path));
                                          }
                                        },
                                        gallery:()async{
                                          Navigator.pop(context);
                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                          if(picked !=null){
                                            cubit.changeCover(image: File(picked.path));
                                          }
                                        }
                                    );
                                  },
                                  icon: Container(
                                    height: 50,
                                    width: 50,
                                    decoration:const  BoxDecoration(
                                        color: Colors.black38,
                                      shape: BoxShape.circle
                                    ),
                                    child: const Center(
                                      child: Icon(IconlyLight.camera,
                                      size: 25,
                                      color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: Colors.white,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                            cubit.imageProfile!=null?CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(cubit.imageProfile!),
                                ):CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(userModel.profile),
                            ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: (){
                                      showDialogImages(
                                        context: context,
                                        camera: ()async{
                                          Navigator.pop(context);
                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.camera,maxHeight: 1080,maxWidth: 1080);
                                          if(picked !=null){
                                            cubit.changeProfile(image: File(picked.path));
                                          }
                                        },
                                        gallery:()async{
                                          Navigator.pop(context);
                                          XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                                          if(picked !=null){
                                            cubit.changeProfile(image: File(picked.path));
                                          }
                                        }
                                      );
                                    },
                                    icon: Container(
                                      height: 50,
                                      width: 50,
                                      decoration:const  BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle
                                      ),
                                      child: const Center(
                                        child: Icon(IconlyLight.camera,
                                            size: 25,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mainButton(
                              text: 'Edit Profile',
                              fct: (){
                                if(cubit.imageProfile!=null){
                                  cubit.updateProfileImage(
                                    name: cubit.nameUpdate.text,
                                    bio: cubit.bioUpdate.text,
                                    phone: cubit.phoneUpdate.text,
                                  );
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(content:const Text('No edit in Profile Image'),
                                      action: SnackBarAction(label: 'Undo !', onPressed: (){})),);
                                }

                              },
                              height: 40
                            ),
                            (state is LoadingUpdateProfile)?
                            const SizedBox(height: 5,):Container(),
                            (state is LoadingUpdateProfile)?
                            const LinearProgressIndicator():Container(),
                          ],
                        )),
                        const SizedBox(width: 5,),
                        Expanded(
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mainButton(
                                    text: 'Edit Cover',
                                    fct: (){
                                      if(cubit.imageCover!=null){
                                        cubit.updateCoverImage(
                                          name: cubit.nameUpdate.text,
                                          bio: cubit.bioUpdate.text,
                                          phone: cubit.phoneUpdate.text,
                                        );
                                      }
                                      else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content:const Text('No edit in cover Image'),
                                              action: SnackBarAction(label: 'Undo !', onPressed: (){})),);
                                      }
                                    },
                                    height: 40
                                ),
                                (state is LoadingUpdateCover)?
                                const SizedBox(height: 5,):Container(),
                                (state is LoadingUpdateCover)?
                                const LinearProgressIndicator():Container(),
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    defaultTextFiled(
                      controller: cubit.nameUpdate,
                      inputType: TextInputType.text,
                      labelText: 'Name',
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter The Name';
                        }
                      },
                      prefixIcon: IconlyLight.profile,
                    ),
                    const SizedBox(height: 8,),
                    defaultTextFiled(
                      controller: cubit.bioUpdate,
                      inputType: TextInputType.text,
                      labelText: 'Bio',
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter The Bio';
                        }
                      },
                      prefixIcon: IconlyLight.folder,
                    ),
                    const SizedBox(height: 8,),
                    defaultTextFiled(
                      controller: cubit.phoneUpdate,
                      inputType: TextInputType.phone,
                      labelText: 'Phone',
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Enter The Phone';
                        }
                      },
                      prefixIcon: IconlyLight.call,
                    ),

                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){

        });
  }
}
