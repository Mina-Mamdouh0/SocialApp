
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:social_app/bloc/social_cubit.dart';
import 'package:social_app/bloc/social_state.dart';
import 'package:social_app/model/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          List<PostModel> postModel=cubit.postsList;
        return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    elevation: 5,
                    child:
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset('assets/images/images.jpg',
                            fit: BoxFit.fill,
                            height: 180,
                            width: double.infinity),
                        Container(
                          color: Colors.black38,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          child: const Text('Commucation To Friends',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                        )

                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Card(
                          elevation: 10,
                          child:
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(postModel[index].userImage),
                                    ),
                                    const SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:  [
                                              Text(postModel[index].userName,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              const SizedBox(width: 10,),
                                              const Icon(Icons.done_all_outlined,color: Colors.blue,)

                                            ],
                                          ),
                                           Text('${postModel[index].dateTime.toDate()}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal
                                            ),),
                                        ],
                                      ),
                                    ),
                                    IconButton(onPressed: (){},
                                        icon: const Icon(Icons.more_horiz,
                                          color: Colors.grey,))
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                (postModel[index].post!='')?Padding(
                                  padding:  const EdgeInsets.only(bottom: 10.0),
                                  child:  Text(postModel[index].post!,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),),
                                ):Container(),
                               /* Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Wrap(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: InkWell(
                                          onTap: (){},
                                          child: const Text('#software',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                              fontSize: 16,
                                            ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                (postModel[index].image!=null)?
                                Image.network(postModel[index].image!,
                                    fit: BoxFit.fill,
                                    height: 180,
                                    width: double.infinity):Container(),
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  [
                                        const Icon(IconlyLight.heart,color: Colors.red,),
                                        const SizedBox(width: 6,),
                                        Text('${postModel[index].likes!=null?postModel[index].likes!.length:0}',
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.comment,color: Colors.grey),
                                        SizedBox(width: 6,),
                                        Text('120',
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),),
                                        SizedBox(width: 6,),
                                        Text('Comment',
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 15,
                                          ),),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                     CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(cubit.signUpModel!.profile),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Expanded(
                                      child: Text('Write the Comment',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal
                                        ),),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        cubit.addLike(postId: postModel[index].postId);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:  [
                                          const Icon(Icons.favorite,color: Colors.red,),
                                          const SizedBox(width: 6,),
                                          const Text('like',
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                              fontSize: 15,
                                            ),),

                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(
                          width: double.infinity,
                          height: 3,
                        );
                      },
                      itemCount: postModel.length
                  ),

                  const SizedBox(height: 10,),


                ],
              ),
            ),
          );
        },
        listener: (context,state){

        });
  }
}
