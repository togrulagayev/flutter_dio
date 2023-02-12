import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dio/models/users_photos_model/users_photos_model.dart';

class UserGalleryPage extends StatefulWidget {
  const UserGalleryPage({super.key});

  @override
  State<UserGalleryPage> createState() => _UserGalleryPageState();
}

class _UserGalleryPageState extends State<UserGalleryPage> {
  late final Future<List<UsersPhotosModel>> _allPhoto;
  @override
  void initState() {
    _allPhoto = getAllPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _allPhoto,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UsersPhotosModel> photos = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200.0,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: photos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // padding: const EdgeInsets.all(8),
                  color: Colors.green[100],
                  child: Image.network(
                    photos[index].downloadUrl,
                    fit: BoxFit.cover,
                  ),
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

Future<List<UsersPhotosModel>> getAllPhotos() async {
  try {
    var response = await Dio().get('https://picsum.photos/v2/list');
    var photos = (response.data as List);
    List<UsersPhotosModel> allPhotos =
        photos.map((photo) => UsersPhotosModel.fromJson(photo)).toList();
    if (response.statusCode == 200) {
      return allPhotos;
    }
    return [];
  } on DioError catch (e) {
    return Future.error(e.message);
  }
}
