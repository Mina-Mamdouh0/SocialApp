import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/screen/auth/login/loginscreen.dart';
import 'package:social_app/screen/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      BlocProvider(
    create: (_)=>SocialCubit()..getDateUser()..getPosts()..getAllUser(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //FirebaseAuth.instance.currentUser!.delete();
    return MaterialApp(
      title: 'Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  FirebaseAuth.instance.currentUser==null?LoginScreen():HomeLayout(),
    );
  }
}
