import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/models/users_models/users_model.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late final Future<List<UsersModel>> _allUser;
  @override
  void initState() {
    _allUser = getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _allUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UsersModel> users = snapshot.data!;
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index].name),
                      subtitle: Text(users[index].email),
                      leading: CircleAvatar(
                        child: Text(users[index].id.toString()),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            }
          }),
    );
  }
}

Future<List<UsersModel>> getAllUsers() async {
  try {
    String baseUrl = 'https://jsonplaceholder.typicode.com';
    var response = await Dio().get('$baseUrl/users');
    var users = (response.data as List);
    List<UsersModel> allUsers =
        users.map((user) => UsersModel.fromJson(user)).toList();
    if (response.statusCode == 200) {
      return allUsers;
    }
    return [];
  } on DioError catch (e) {
    return Future.error(e.message);
  }
}
