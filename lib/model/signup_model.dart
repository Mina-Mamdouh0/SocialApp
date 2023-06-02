class SignUpModel{
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String profile;
  final String cover;
  final String bio;

  SignUpModel({required this.name,required this.email,required this.phone,required this.uId,required this.cover,required this.profile,required this.bio, });

  factory SignUpModel.formJson(Map<String, dynamic> json,){
     return SignUpModel(
        name: json['Name'],
        email:json['Email'],
        phone: json['Phone'],
        uId: json['Id'],
       bio: json['Bio'],
       cover: json['Cover'],
       profile: json['Profile'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Email':email,
      'Phone': phone,
      'Id': uId,
      'Bio': bio,
      'Cover': cover,
      'Profile': profile,
    };

  }
}