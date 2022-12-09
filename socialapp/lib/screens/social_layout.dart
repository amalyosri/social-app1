import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit.dart';

import '../componants/componant.dart';
import '../cubit/social_state.dart';
import '../style/icon_broken.dart';
import 'addpost.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {
        if (state is ChangeBottombarAddPostState) {
          navigateto(context, AddPost());
        }
      }),
      builder: ((context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.screentitles[cubit.currentindex]),
            actions: [
              IconButton(
                  onPressed: (() {}),
                  icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: (() {}), icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screenBottomBar[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: ((value) {
                cubit.changebottombar(value);
              }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home), label: "home"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: "Chat"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: "Post"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: "User"),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: "Setting"),
              ]),
        );
      }),
    );
  }
}
