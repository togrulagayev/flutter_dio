import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dio/models/users_mails_models/users_mails_model.dart';

class UsersMailPage extends StatefulWidget {
  const UsersMailPage({super.key});

  @override
  State<UsersMailPage> createState() => _UsersMailPageState();
}

class _UsersMailPageState extends State<UsersMailPage> {
  late final Future<List<UsersMailModel>> _allMail;
  @override
  void initState() {
    _allMail = getAllMails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _allMail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UsersMailModel> mails = snapshot.data!;
            return ListView.builder(
              itemCount: mails.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(mails[index].email),
                  subtitle: Text(mails[index].name),
                  iconColor: Colors.deepPurple,
                  children: [
                    ListTile(
                      title: Text(mails[index].body),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          }
        },
      ),
    );
  }
}

Future<List<UsersMailModel>> getAllMails() async {
  try {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/comments');
    var mails = (response.data as List);
    List<UsersMailModel> allMails =
        mails.map((mail) => UsersMailModel.fromJson(mail)).toList();
    if (response.statusCode == 200) {
      return allMails;
    }
    return [];
  } on DioError catch (e) {
    return Future.error(e.message);
  }
}
