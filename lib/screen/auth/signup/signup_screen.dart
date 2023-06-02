
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/screen/auth/signup/bloc/cubit_signup.dart';
import 'package:social_app/screen/auth/signup/bloc/state_signup.dart';
import 'package:social_app/screen/home.dart';
import 'package:social_app/shared/companet.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>SignUpCubit(),
        child: BlocConsumer<SignUpCubit,SignUpStates>(
          listener: (context,state){
            if(state is SuccessCreateUserScreen){
              navigatorAndRemove(context: context,widget: HomeLayout());
            }
            else if (state is ErrorSignUpScreen){
              showToast(color: Colors.red,msg: 'Check in information');
            }
            else if (state is ErrorCreateUserScreen){
              showToast(color: Colors.red,msg: 'Dear User please create account again');
            }
          },
          builder: (context,state){
            return Scaffold(
                body:Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sign Up',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: Colors.black
                              ),),
                            const SizedBox(height: 15,),
                            Text('Sign Up now with Friends',
                                style: Theme.of(context).textTheme.headline5),
                            const SizedBox(height: 25,),
                            defaultTextFiled(
                              controller: nameController,
                              inputType: TextInputType.text,
                              labelText: 'Name',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter The Name';
                                }
                              },
                              prefixIcon: Icons.person,
                            ),
                            const SizedBox(height: 15,),
                            defaultTextFiled(
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              labelText: 'Email Address',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter The Email';
                                }
                              },
                              prefixIcon: Icons.email,
                            ),
                            const SizedBox(height: 15,),
                            defaultTextFiled(
                              controller: passwordController,
                              inputType: TextInputType.visiblePassword,
                              labelText: 'Password',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Password is Shorted';
                                }
                              },
                              prefixIcon: Icons.lock,
                              suffixIcon: SignUpCubit.get(context).obscureText?Icons.visibility:Icons.visibility_off,
                                fctSuffixIcon: ()=>SignUpCubit.get(context).visiblePassword(),
                              obscureText: SignUpCubit.get(context).obscureText
                            ),
                            const SizedBox(height: 15,),
                            defaultTextFiled(
                              controller: phoneController,
                              inputType: TextInputType.phone,
                              labelText: 'Phone Number',
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please Enter The Phone';
                                }

                              },
                              prefixIcon: Icons.phone,
                            ),
                            const SizedBox(height: 25,),
                            (state is! LoadingSignUpScreen)?
                            MaterialButton(
                              onPressed: (){
                                if(formKey.currentState!.validate()){
                                  SignUpCubit.get(context).userSignUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,);
                                }
                                },
                              minWidth: double.infinity,
                              color: Colors.blue,
                              textColor: Colors.white,
                              height: 50,
                              child:  const Text('Create Account',style: TextStyle(
                                  fontSize: 20
                              ),),
                            ):
                            const Center(child:CircularProgressIndicator()),
                            const SizedBox(height: 15,),
                            Row(
                              children: [
                                const Text('Do have a account?',
                                  style: TextStyle(fontSize: 16
                                  ),),
                                useTextButton(name: 'Login',
                                    onPress: ()=>Navigator.pop(context))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            );
          },
        )
    );
  }
}
