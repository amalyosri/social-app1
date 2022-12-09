class PostModel {
  String? name;
  String? uId;
  String? image;
  String? text;
  String? datetime;
  String? imagepost;
  PostModel(
      {required this.name,
      required this.uId,
      required this.datetime,
      required this.image,
      required this.imagepost,
      required this.text});

  PostModel.fromjson(Map<String, dynamic>? json) {
    // final json1 = json.data();

    name = json?["name"];
    datetime = json?["datetime"];
    imagepost = json?["imagepost"];
    uId = json?["uId"];
    text = json?["text"];
    image = json?["image"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "text": text,
      "imagepost": imagepost,
      "uId": uId,
      "datetime": datetime,
      "image": image,
    };
  }
}
