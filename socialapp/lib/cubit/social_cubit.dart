// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, curly_braces_in_flow_control_structures, unnecessary_this, unnecessary_null_comparison, prefer_is_empty

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/cubit/social_state.dart';
import 'package:socialapp/model/chatmessage.dart';
import 'package:socialapp/model/post_model.dart';
import 'package:socialapp/screens/chats.dart';
import 'package:socialapp/screens/home.dart';
import 'package:socialapp/screens/setting.dart';
import 'package:socialapp/screens/user.dart';
import '../componants/constunt.dart';
import '../model/create_user.dart';
import '../screens/addpost.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialState());

  int currentindex = 0;

  List<Widget> screenBottomBar = [
    const HomeScreen(),
    const ChatScreen(),
    AddPost(),
    const UserScreen(),
    const SettingScreen(),
  ];

  List<String> screentitles = ["Home", "Chat", "Add post", "User", "Setting"];

  static SocialCubit get(context) => BlocProvider.of(context);

  CreateUser? usermodel;
  void getUserData() {
    emit(Socialloding());

    FirebaseFirestore.instance
        .collection("user")
        .doc(token1)
        .snapshots()
        .listen((event) async {
      usermodel = CreateUser.fromjson(event.data());
      print(usermodel);
      //  print(value.data());
      emit(SocialSuccess());
    });

    // FirebaseFirestore.instance
    //     .collection("user")
    //     .doc(token1)
    //     .get()
    //     .then((value) {
    //   // print(value.data());

    //   model = CreateUser.fromjson(value.data());
    //   print(model);
    //   emit(SocialSuccess());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(SocialError(error));
    // });
  }

  void changebottombar(int index) {
    if (index == 1) getalluserchat();
    if (index == 2)
      emit(ChangeBottombarAddPostState());
    else {
      currentindex = index;
      emit(ChangeBottombarState());
    }
  }

  File? profileimage;
  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      this.profileimage = imageTemp;
      // print(profileimage);
      emit(ProfileImageSuccessState());
    } on PlatformException catch (e) {
      print("image picker faild: $e");
      emit(ProfileImageErrorState());
    }
  }

  File? coverImage;
  var coverpicker = ImagePicker();

  Future<void> getcoverImage() async {
    final cover = await coverpicker.pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      coverImage = File(cover!.path);
      emit(CoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImageErrorState());
    }
  }

  // String profileimageUrl = "";
  void uploadprofileimage(bio, name, phone) {
    emit(UpdateUserDataLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("User/${Uri.file(profileimage!.path).pathSegments.last}")
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);
        // profileimageUrl = value;
        upDateUserData(bio: bio, name: name, phone: phone, image: value);
        //emit(UploadProfileImageSuccessState());
      }).catchError((error) {
        print("error in dowenlod Url ${error.toString()}");
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print("upload in url ${error.toString()}");
      emit(UploadProfileImageErrorState());
    });
  }

  // String coverimageUrl = "";
  void uploadcoverimage(
    name,
    phone,
    bio,
  ) {
    // emit(UpdateUserDataLodingState());
    emit(UpdateUserDataCoverLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("User/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);
        // coverimageUrl = value;
        upDateUserData(bio: bio, name: name, phone: phone, cover: value);
        // emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        print("error in dowenlod Url ${error.toString()}");
        emit(UploadCoverImageErrorState());
      });
    }).catchError((error) {
      print("upload in url ${error.toString()}");
      emit(UploadCoverImageErrorState());
    });
  }

  void upDateUserData(
      {required String name,
      required String phone,
      required String bio,
      String? cover,
      String? image}) {
    emit(UpdateUserDataLodingState());
    CreateUser model = CreateUser(
      name: name,
      phone: phone,
      bio: bio,
      email: usermodel!.email,
      uId: usermodel!.uId,
      isverified: false,
      cover: cover ?? usermodel!.cover,
      image: image ?? usermodel!.image,
      pass: usermodel!.pass,
    );
    FirebaseFirestore.instance
        .collection("user")
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }

//////////////////////////////////////////////////////////////////////

  void uploadPostImage({
    required String text,
    required String datetime,
  }) {
    emit(UplodePostImageLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("User/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // print(value);
        // coverimageUrl = value;
        createNewpost(text: text, datetime: datetime, imagepost: value);
        // emit(UploadCoverImageSuccessState());
      }).catchError((error) {
        print("error in dowenlod Url ${error.toString()}");
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      print("upload in url ${error.toString()}");
      emit(UploadPostImageErrorState());
    });
  }

  void createNewpost({
    required String text,
    required String datetime,
    String? imagepost,
  }) {
    //  emit(CreateNewPostImageLoadingState());
    emit(UplodePostImageLodingState());
    PostModel model = PostModel(
        name: usermodel!.name,
        uId: usermodel!.uId,
        datetime: datetime,
        image: usermodel!.image,
        imagepost: imagepost ?? "",
        text: text);
    FirebaseFirestore.instance
        .collection("Posts")
        .add(model.toMap())
        .then((value) {
      emit(CreateNewPostImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateNewPostImageErrorState());
    });
  }

  File? postImage;
  var postpicker = ImagePicker();

  Future<void> getPostImage() async {
    final post = await coverpicker.pickImage(
      source: ImageSource.gallery,
    );

    if (PickedFile != null) {
      postImage = File(post!.path);
      emit(PostImageSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImageErrorState());
    }
  }

  void removepostimage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  /////////////////home data////////////////////

  List<PostModel> postsdata = [];
  List<String> postId = [];
  List<int> likeNum = [];
  //var postsdata1=[];
  void gethomedata() {
    FirebaseFirestore.instance
        .collection("Posts")
        // .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Likes").get().then((value) {
          likeNum.add(value.docs.length);
          postId.add(element.id);

          postsdata.add(PostModel.fromjson(element.data()));
          //  postsdata1= postsdata.where((element) =>element.uId== usermodel!.uId);
        }).catchError((error) {});
      });
      emit(GetPostDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostDataErrorState());
    });
  }

  void likepost(String postId) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(usermodel!.uId)
        .set({"like": true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LikePostErrorState());
    });
  }

  List<CreateUser> alluserlist = [];
  void getalluserchat() {
    if (alluserlist.length == 0)
      FirebaseFirestore.instance.collection("user").get().then((value) {
        value.docs.forEach((element) {
          if (element.data()["uId"] != usermodel!.uId)
            alluserlist.add(CreateUser.fromjson(element.data()));
          emit(ChatSuccessState());
        });
      }).catchError((error) {
        print(error.toString());
        emit(ChatErrorState());
      });
  }

  void sendMessage({
    receiverId,
    textmsg,
    datetime,
  }) {
    ChatMessage model = ChatMessage(
        receiverId: receiverId,
        textmsg: textmsg,
        datetime: datetime,
        senderId: usermodel!.uId);
////////////sender msg
    FirebaseFirestore.instance
        .collection("user")
        .doc(usermodel!.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .add(model.toMap())
        .then(
      (value) {
        emit(SendChatSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SendChatErrorState());
    });
////////msg reciver
    FirebaseFirestore.instance
        .collection("user")
        .doc(receiverId)
        .collection("chat")
        .doc(usermodel!.uId)
        .collection("message")
        .add(model.toMap())
        .then(
      (value) {
        emit(GetChatSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(GetChatErrorState());
    });
  }

  List<ChatMessage> message = [];

  void getreeltimemessage(receiverId) {
    FirebaseFirestore.instance
        .collection("user")
        .doc(usermodel!.uId)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .orderBy("datetime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(ChatMessage.fromjson(element.data()));
      });
      emit(GetChatSuccessState());
    });
  }
}
