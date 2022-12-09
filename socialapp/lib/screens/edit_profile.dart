import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/social_cubit.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/style/icon_broken.dart';

import '../componants/componant.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var namecontroller = TextEditingController();
  var biocontroller = TextEditingController();
  var phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        var model = SocialCubit.get(context).usermodel;
        File? profileimage = SocialCubit.get(context).profileimage;
        File? coverimage = SocialCubit.get(context).coverImage;
        namecontroller.text = model?.name ?? "";
        biocontroller.text = model?.bio ?? "";
        phonecontroller.text = model?.phone ?? "";
        return Scaffold(
          appBar: appbar(context: context, title: "Edit Profile", actions: [
            TextButton(
                onPressed: () {
                  SocialCubit.get(context).upDateUserData(
                      name: namecontroller.text,
                      phone: phonecontroller.text,
                      bio: biocontroller.text);
                },
                child: const Text("UPDATE")),
            const SizedBox(
              width: 10,
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // color: Colors.amber,
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
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
                                    image: coverimage == null
                                        ? NetworkImage("${model!.cover}")
                                        : FileImage(coverimage)
                                            as ImageProvider),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getcoverImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: profileimage == null
                                        ? NetworkImage("${model!.image}")
                                        : FileImage(profileimage)
                                            as ImageProvider?),
                              ),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getImage();
                                  },
                                  icon: const Icon(IconBroken.Camera),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (profileimage != null && coverimage != null)
                    const SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      if (profileimage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "UPLOAD PROFILE",
                                  function: () {
                                    SocialCubit.get(context).uploadprofileimage(
                                        biocontroller.text,
                                        namecontroller.text,
                                        phonecontroller.text);
                                  },
                                  context: context),
                              if (state is UpdateUserDataLodingState)
                                const LinearProgressIndicator()
                            ],
                          ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (coverimage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "UPLOAD COVER",
                                  function: () {
                                    SocialCubit.get(context).uploadcoverimage(
                                        namecontroller.text,
                                        phonecontroller.text,
                                        biocontroller.text);
                                  },
                                  context: context),
                              if (state is UpdateUserDataCoverLodingState)
                                const LinearProgressIndicator()
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textfeild(namecontroller, "Name", const Icon(IconBroken.User),
                      TextInputType.name, (value) {
                    if (value.isEmpty) {
                      return "name must not be Empty";
                    } else {
                      return null;
                    }
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  textfeild(
                      biocontroller,
                      "Bio",
                      const Icon(IconBroken.Info_Circle),
                      TextInputType.name, (value) {
                    if (value.isEmpty) {
                      return "Bio must not be Empty";
                    } else {
                      return null;
                    }
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  textfeild(phonecontroller, "Phone", const Icon(Icons.phone),
                      TextInputType.number, (value) {
                    if (value.isEmpty) {
                      return "Phone must not be Empty";
                    } else {
                      return null;
                    }
                  })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
