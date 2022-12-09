class CreateUser {
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isverified;
  String? image;
  String? bio;
  String? cover;
  String? pass;

  CreateUser(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isverified,
      required this.image,
      required this.bio,
      required this.cover,
      required this.pass});

  // factory CreateUser.fromjson(Map<String, dynamic>? json) {
  //   // final json1 = json.data();
  //   return CreateUser(
  //       name: json!["name"],
  //       email: json["email"],
  //       phone: json["phone"],
  //       uId: json["uId"],
  //       isverified: json["isverified"]);
  // }

  CreateUser.fromjson(Map<String, dynamic>? json) {
    // final json1 = json.data();

    name = json?["name"];
    email = json?["email"];
    phone = json?["phone"];
    uId = json?["uId"];
    isverified = json?["isverified"];
    image = json?["image"];
    bio = json?["bio"];
    cover = json?["cover"];
    pass = json?["pass"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "isverified": isverified,
      "image": image,
      "bio": bio,
      "cover": cover,
      "pass": pass
    };
  }

  // static CreateUser toemail(Map<String, dynamic>? mail) {
  //   return CreateUser(
  //       name: mail!["name"],
  //       email: mail["email"],
  //       phone: mail["phone"],
  //       uId: mail["uId"],
  //       isverified: mail["isverified"]);
  // }

//   String toJson() => json.encode(toMap());

//   factory CreateUser.fromJson(String source) =>
//       CreateUser.fromjson(json.decode(source));
}
