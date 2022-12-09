// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/model/create_user.dart';
import 'package:socialapp/style/icon_broken.dart';

// ignore: must_be_immutable
class ChatDetails extends StatelessWidget {
  CreateUser model;
  ChatDetails({required this.model});

  var textmsg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getreeltimemessage(model.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
          listener: ((context, state) {}),
          builder: ((context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage("${model.image}")),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${model.name}",
                    ),
                  ]),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            var message =
                                SocialCubit.get(context).message[index];
                            if (model.uId == message.senderId) {
                              return buildmessage(message);
                            } else {
                              return myMessage(message);
                            }
                          }),
                          separatorBuilder: ((context, index) {
                            return const SizedBox(
                              height: 15,
                            );
                          }),
                          itemCount: SocialCubit.get(context).message.length),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textmsg,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: InputBorder.none,
                                  hintText: "type your message here ..."),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.pink,
                            child: MaterialButton(
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                    datetime: DateTime.now().toString(),
                                    textmsg: textmsg.text,
                                    receiverId: model.uId);
                                textmsg.text = "";
                              },
                              child: const Icon(
                                IconBroken.Send,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }));
    });
  }

  Widget buildmessage(model) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 232, 223, 223),
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text(model.textmsg),
      ),
    );
  }

  Widget myMessage(model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.pink.withOpacity(0.2),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Text(model.textmsg),
      ),
    );
  }
}
