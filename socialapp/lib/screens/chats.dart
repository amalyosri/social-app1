import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/componants/componant.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/screens/chatdetails.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((context, index) => chatItem(
                  SocialCubit.get(context).alluserlist[index], context)),
              separatorBuilder: ((context, index) => myDivider()),
              itemCount: SocialCubit.get(context).alluserlist.length);
        }));
  }

  Widget chatItem(model, context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          CircleAvatar(
              radius: 25, backgroundImage: NetworkImage("${model.image}")),
          const SizedBox(
            width: 5,
          ),
          Text("${model.name}"),
        ]),
      ),
      onTap: () {
        navigateto(context, ChatDetails(model: model));
      },
    );
  }
}
