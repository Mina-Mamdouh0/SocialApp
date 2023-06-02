
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/model/chat_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/signup_model.dart';
import 'package:social_app/screen/mainscreen/add_post_screen.dart';
import 'package:social_app/screen/mainscreen/chat_screen.dart';
import 'package:social_app/screen/mainscreen/feed_screen.dart';
import 'package:social_app/screen/mainscreen/setting_screen.dart';
import 'package:social_app/screen/mainscreen/users_screen.dart';
import 'package:uuid/uuid.dart';

class SocialCubit extends Cubit<SocialState>{
  SocialCubit() : super(InitialState());

  static SocialCubit get(context)=>BlocProvider.of(context);

  SignUpModel? signUpModel;
  String? url;
  String userId=FirebaseAuth.instance.currentUser!.uid;
  var nameUpdate=TextEditingController();
  var bioUpdate=TextEditingController();
  var phoneUpdate=TextEditingController();
  List<SignUpModel> usersDate=[];
  List<ChatModel> chats=[];

  File? imageProfile;
  File? imageCover;
  File? postImage;

  List<PostModel> postsList=[];

  int currentIndex=0;
  List<Widget> screens=[
    const FeedsScreen(),
    const ChatScreen(),
     AddPostScreen(),
    const UsersScreen(),
    const SettingScreen(),
  ];
  List<String> screenName=[
    'Feed News',
    'Chats',
    'Add Post',
    'Users',
    'Settings',
  ];

  void changeIndexBottom(int index){
    if(index==2){
      emit(PostScreenState());
    }else{
      currentIndex=index;
      emit(BottomNavState());
    }
  }

  void getDateUser(){
    emit(LoadingGetUserScreen());
    FirebaseFirestore.instance.collection('Users').doc(userId).get().
    then((value){
      signUpModel=SignUpModel.formJson(value.data()!);
      nameUpdate.text=value.get('Name');
      bioUpdate.text=value.get('Bio');
      phoneUpdate.text=value.get('Phone');
      emit(SuccessGetUserScreen());
    }).onError((error,_){
      emit(ErrorGetUserScreen(error.toString()));
    });
  }

  void getAllUser(){
    emit(LoadingGetAllUser());
    FirebaseFirestore.instance
        .collection('Users').get().
    then((value){
      for (var element in value.docs) {
        usersDate.add(SignUpModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser(error.toString()));
    });
  }


  void changeProfile({required File image,}){
    imageProfile=image;
    emit(ChangeProfileImage());
  }
  void changeCover({required File image,}){
    imageProfile=image;
    emit(ChangeProfileImage());
  }


  void showImagePost({required File image,}){
    postImage=image;
    emit(ShowImagePost());
  }

  void clearImagePost(){
    postImage=null;
    emit(ClearImagePost());
  }

  void updateProfileImage({required String name, required String bio, required String phone,})async{
    emit(LoadingUpdateProfile());
    final ref= FirebaseStorage.instance.ref().child('UsersImage').
    child(userId).
    child('profileImage.jpg');
    await ref.putFile(imageProfile!).then((p0)async {
      url =await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('Users').doc(userId).update({
        'Profile': url??'https://www.dancehallmag.com/assets/2021/03/burna-boy.jpg',
      });
      updateUserDate(
        name: name,
        bio: bio,
        phone: phone,);
      getDateUser();
      emit(SuccessUpdateProfile());
    }).onError((error, _){
      emit(ErrorUpdateProfile(error.toString()));
    });
  }

  void updateCoverImage({
    required String name,
    required String bio,
    required String phone,
  })async{
    emit(LoadingUpdateCover());
    final ref= FirebaseStorage.instance.ref().child('UsersImage').
    child(userId).
    child('CoverImage.jpg');
    await ref.putFile(imageCover!).then((p0)async {
      url =await ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('Users').doc(userId).update({
        'Cover': url??'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/health/wp-content/uploads/2022/01/foods_to_eat_to_lose_weight.jpeg',
      });
      updateUserDate(
        name: name,
        bio: bio,
        phone: phone,);
      getDateUser();
      emit(SuccessUpdateCover());
    }).onError((error, _){
      emit(ErrorUpdateCover(error.toString()));
    });
  }

  void updateUserDate({required String name, required String bio, required String phone,
}){
    emit(LoadingUpdateUser());
    FirebaseFirestore.instance
        .collection('Users').doc(userId).update({
      'Name': name,
      'Bio':bio,
      'Phone': phone,
    }).
    then((value){
      getDateUser();
        emit(SuccessUpdateUser());
    }).onError((error,_){
      emit(ErrorUpdateUser(error.toString()));
    });
  }


  void addPost({required String post}){
    String uIdPost=const Uuid().v4();
    PostModel model=PostModel(
      dateTime: Timestamp.now(),
      post: post,
      userId: userId,
      userName: signUpModel!.name,
      userImage: signUpModel!.profile,
      postId:uIdPost,
     //likes: [],
    );
    emit(LoadingAddPost());
    FirebaseFirestore.instance.collection('Posts').doc(uIdPost)
      .set(model.toMap())
        .then((value){
      emit(SuccessAddPost());
    }).onError((error,_){
      emit(ErrorAddPost(error.toString()));
    });
  }

  void addPostWithImage({String? post,})async{
    emit(LoadingPostWithImage());
    String uIdPost=const Uuid().v4();
    final ref= FirebaseStorage.instance.ref().child('Posts').
    child(userId).
    child('$post.jpg');
    await ref.putFile(postImage!).then((p0)async {
      url =await ref.getDownloadURL();
      PostModel model=PostModel(
        image: url!,
        dateTime: Timestamp.now(),
        post: post,
        userId: userId,
        userName: signUpModel!.name,
        userImage: signUpModel!.profile,
        postId:uIdPost,
      );
      FirebaseFirestore.instance.collection('Posts').doc(uIdPost).
      set(model.toMap())
          .then((value){
        emit(SuccessPostWithImage());
      });
    }).onError((error,_){
      emit(ErrorPostWithImage(error.toString()));
    });
  }

  void getPosts()async{
    postsList=[];
    emit(LoadingGetPostsState());
     FirebaseFirestore.instance.collection('Posts').
     orderBy('DateTime',descending: true).
    get().
    then((value){
      for (var element in value.docs) {
        postsList.add(PostModel.formJson(element.data()));
          emit(SuccessGetPostsState());
      }
    }).onError((error,_){
      emit(ErrorGetPostsState(error.toString()));
    });
  }



  void addLike({required String postId}){
    emit(LoadingAddLikeState());
    FirebaseFirestore.instance.collection('Posts').
    doc(postId).update({
      'Likes':FieldValue.arrayUnion([{
        'userId':userId,
        'time':Timestamp.now(),
      }]),
    }).then((value){
      print('isLike');
      emit(SuccessAddLikeState());
    }).onError((error,_){
      emit(ErrorAddLikeState(error.toString()));
    });
  }

  void sendMessage({required String resendId,required String message}){
    //var uuId=const Uuid().v4();
    ChatModel model=ChatModel(
      dateTime: Timestamp.now(),
      message: message,
      resendId: resendId,
      senderId: userId,
    );
    emit(LoadingSendMessage());
    FirebaseFirestore.instance.collection('Users').
    doc(userId).collection('Chats').doc(resendId).collection('Message').add(model.toMap())
    .then((value){
      emit(SuccessSendMessage());
    }).onError((error,_){
      emit(ErrorSendMessage(error.toString()));
    });

    FirebaseFirestore.instance.collection('Users').
    doc(resendId).collection('Chats').doc(userId).collection('Message').add(model.toMap())
        .then((value){
      emit(SuccessSendMessage());
    }).onError((error,_){
      emit(ErrorSendMessage(error.toString()));
    });
  }

  void getMessage({required String resendId,}){
    emit(LoadingGetMessage());
    FirebaseFirestore.instance.collection('Users').
    doc(userId).collection('Chats').doc(resendId).collection('Message').
    orderBy('DateTime',descending: true).snapshots().
    listen((event) {
      chats=[];
      for (var element in event.docs) {
        chats.add(ChatModel.formJson(element.data()));
      }
    }

    );
  }
}