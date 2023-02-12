import 'dart:convert';

List<UsersMailModel> usersMailFromJson(String str) => List<UsersMailModel>.from(
    json.decode(str).map((x) => UsersMailModel.fromJson(x)));

String usersMailToJson(List<UsersMailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersMailModel {
  UsersMailModel({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  factory UsersMailModel.fromJson(Map<String, dynamic> json) => UsersMailModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
