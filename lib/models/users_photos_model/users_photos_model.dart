import 'dart:convert';

List<UsersPhotosModel> usersPhotosFromJson(String str) =>
    List<UsersPhotosModel>.from(
        json.decode(str).map((x) => UsersPhotosModel.fromJson(x)));

String usersPhotosToJson(List<UsersPhotosModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersPhotosModel {
  UsersPhotosModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory UsersPhotosModel.fromJson(Map<String, dynamic> json) =>
      UsersPhotosModel(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
