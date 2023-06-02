import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  String? post;
  final String postId;
  final String userId;
  final String userImage;
  final String userName;
  String? image;
  final Timestamp dateTime;
  List<String>? tags;
  List<dynamic>? likes;


  PostModel({this.post,required this.userId, this.image,required this.dateTime,required this.userImage,required this.userName, this.tags,required this.postId,
      this.likes});

  factory PostModel.formJson(Map<String, dynamic> json,){
    return PostModel(
      post: json['Post'],
      userId:json['UserId'],
      image: json['Image'],
      dateTime: json['DateTime'],
      userImage: json['UserImage'],
      userName: json['UserName'],
      tags: json['Tags'],
      postId: json['PostId'],
      likes: json['Likes'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Post': post,
      'UserId':userId,
      'Image': image,
      'DateTime': dateTime,
      'UserImage': userImage,
      'UserName': userName,
      'Tags':tags,
      'PostId':postId,
      'Likes':likes,
    };

  }



}