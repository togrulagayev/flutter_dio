import 'package:flutter/material.dart';
import 'package:flutter_dio/screens/users_screen.dart';

import 'users_galery_screen.dart';
import 'users_mail_screen.dart';

class MyTabs extends StatelessWidget {
  const MyTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'SUZAN',
              style: TextStyle(fontFamily: 'Revamped', fontSize: 50.0),
            ),
            centerTitle: true,
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.person_outline, size: 35.0)),
              Tab(icon: Icon(Icons.mail_outline, size: 35.0)),
              Tab(icon: Icon(Icons.photo_outlined, size: 35.0)),
            ]),
          ),
          body: const TabBarView(children: [
            UsersPage(),
            UsersMailPage(),
            UserGalleryPage(),
          ]),
        ));
  }
}
