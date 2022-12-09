// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/style/icon_broken.dart';

import '../componants/componant.dart';
import 'home.dart';

// ignore: must_be_immutable
class AddPost extends StatelessWidget {
  AddPost({Key? key}) : super(key: key);
  var textpost = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return Scaffold(
          appBar: appbar(context: context, title: "Create Post", actions: [
            TextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createNewpost(
                        text: textpost.text, datetime: now.toString());
                    // navigateto(context, const HomeScreen());
                    // SocialCubit.get(context).currentindex = 0;
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                        text: textpost.text, datetime: now.toString());
                    //navigateto(context, const HomeScreen());
                  }
                },
                child: const Text("POST"))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (state is UplodePostImageLodingState)
                  const LinearProgressIndicator(),
                if (state is UplodePostImageLodingState)
                  const SizedBox(
                    height: 8,
                  ),
                Row(children: [
                  CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          "${SocialCubit.get(context).usermodel!.image}")),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(SocialCubit.get(context).usermodel!.name ?? "",
                      style: Theme.of(context).textTheme.bodyText1),
                ]),
                Expanded(
                  child: TextFormField(
                    controller: textpost,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        hintText: "What is in your mind...",
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: const AlignmentDirectional(0.9, -0.8),
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 20,
                        //margin: EdgeInsets.all(8.0),
                        child: Image(
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image:
                                FileImage(SocialCubit.get(context).postImage!)
                                    as ImageProvider),
                      ),
                      CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            SocialCubit.get(context).removepostimage();
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                SocialCubit.get(context).getPostImage();
                              },
                              child: Row(
                                children: const [
                                  Icon(IconBroken.Image),
                                  Text("add Photo")
                                ],
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: const Text("#tags")))
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
