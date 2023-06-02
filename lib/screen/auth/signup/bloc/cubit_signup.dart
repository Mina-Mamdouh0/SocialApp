import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/model/signup_model.dart';
import 'package:social_app/screen/auth/signup/bloc/state_signup.dart';

class SignUpCubit extends Cubit<SignUpStates>{
  SignUpCubit() : super(InitialState());

  static SignUpCubit get(context)=>BlocProvider.of(context);

  bool obscureText=true;

void userSignUp({required String email, required String password, required String name, required String phone,}){

  emit(LoadingSignUpScreen());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password).then((value){
        //emit(SuccessSignUpScreen());
        createUser(name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid);
  }).onError((error,_){
    emit(ErrorSignUpScreen(error.toString()));
  });
}

void createUser({required String email, required String uId, required String name, required String phone,}){
  SignUpModel model=SignUpModel(name: name, email: email, phone: phone, uId: uId, bio: 'bio ...',
      profile: 'https://www.dancehallmag.com/assets/2021/03/burna-boy.jpg',
      cover: 'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/health/wp-content/uploads/2022/01/foods_to_eat_to_lose_weight.jpeg');
  emit(LoadingCreateUserScreen());
  FirebaseFirestore.instance.collection('Users').doc(uId).set(
      model.toMap()
  ).then((value){
    emit(SuccessCreateUserScreen());
  }).onError((error,_){
    emit(ErrorCreateUserScreen(error.toString()));
  });
}

void visiblePassword(){
  obscureText=!obscureText;
  emit(VisiblePasswordSignUp());
}
}