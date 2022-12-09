// ignore_for_file: unused_local_variable, prefer_is_empty

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/componants/constunt.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/style/icon_broken.dart';

import '../componants/componant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        if (SocialCubit.get(context).postsdata == []) {
          return Text("data");
        }
        if (SocialCubit.get(context).postsdata.length > 0 &&
                SocialCubit.get(context).usermodel != null ||
            state is GetPostDataSuccessState) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ignore: prefer_const_literals_to_create_immutables
                Stack(alignment: const Alignment(0.8, 0.6), children: [
                  const Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 20,
                    margin: EdgeInsets.all(8.0),
                    child: Image(
                        height: 210,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/joyful-parisian-woman-beret-sunglasses-points-place-text-purple-wall_197531-24604.jpg?w=900&t=st=1662913290~exp=1662913890~hmac=1685ac1d9c09a178c0c3291ddad372fce3210c97536124659bda560544f54ae9")),
                  ),
                  Text("Communicate With Friends",
                      style: Theme.of(context).textTheme.subtitle1),
                ]),

                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) => buildpostItem(context,
                        SocialCubit.get(context).postsdata[index], index)),
                    separatorBuilder: ((context, index) => const SizedBox(
                          height: 5,
                        )),
                    itemCount: SocialCubit.get(context).postsdata.length),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget buildpostItem(context, PostModel model, index) {
    File? postimage = SocialCubit.get(context).postImage;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              CircleAvatar(
                  radius: 25,
                  backgroundImage: model.image == null
                      ? const AssetImage("assets/image/user.png")
                          as ImageProvider
                      : NetworkImage(model.image ?? ""
                          // SocialCubit.get(context).usermodel!.image ?? ""
                          )),
              //model.image!
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(model.name ?? ""
                            // "${SocialCubit.get(context).usermodel!.name}"
                            ),
                        Icon(
                          Icons.check_circle,
                          color: deffultcolor,
                          size: 16,
                        )
                      ],
                    ),
                    Text(
                      datetime("${model.datetime}"),
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Text(
              "${model.text}",
              // textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10.0, top: 5),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 4.0),
                      child: SizedBox(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            "#software",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(color: deffultcolor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.imagepost != "")
              Container(
                height: 195,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        image: NetworkImage(model.imagepost!),
                        fit: BoxFit.cover)),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            Text(
                              "${SocialCubit.get(context).likeNum[index]}",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                            ),
                            Text(
                              "0 comment",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(model.image ??
                                  //SocialCubit.get(context).usermodel!.image ??
                                  "")),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Write a comment...",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        Text(
                          "Like",
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    SocialCubit.get(context)
                        .likepost(SocialCubit.get(context).postId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
