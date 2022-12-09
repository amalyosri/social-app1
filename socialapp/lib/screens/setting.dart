import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/componants/componant.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import '../dio_helper/cashe_helper.dart';
import 'edit_profile.dart';
import 'login/loginscreen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var model = SocialCubit.get(context).usermodel;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.amber,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 20,
                        //margin: EdgeInsets.all(8.0),
                        child: model?.cover == null
                            ? Container(
                                color: Colors.grey,
                              ) //const Icon(Icons.error)
                            : Image(
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage("${model?.cover}")),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                              radius: 55,
                              backgroundImage: model?.image == null
                                  ? AssetImage("assets/image/user.png")
                                      as ImageProvider
                                  : NetworkImage("${model?.image}")),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${model?.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  "${model?.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "180",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Posts",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {}),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "100",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Photos",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {}),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "10K",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Followers",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {}),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "64",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  "Followings",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: () {}),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {},
                            child: const Text("Edit Profile"))),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateto(context, EditProfile());
                        },
                        child: const Icon(Icons.edit))
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .subscribeToTopic("announcement");
                        },
                        child: const Text("Subscribe")),
                    const SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance
                              .unsubscribeFromTopic("announcement");
                        },
                        child: const Text("unSubscribe"))
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: Colors.pink,
                  child: MaterialButton(
                    onPressed: () {
                      CacheHelper.removedata("uId").then((value) {
                        if (value == true) {
                          finash_navigate(context, Login_Screen());
                        }
                      });
                    },
                    child: const Text(
                      "Log out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
