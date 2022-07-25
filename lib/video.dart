import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashbord_controller.dart';

class Videos extends StatelessWidget {
  final dashBordController = Get.put(DashBordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: const Text("Tech"),
            leading: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              dashBordController.getImageGallery().whenComplete(() =>
                  dashBordController.userImage(
                      platform: "Tech", place: dashBordController.videos));
            },
          ),
          ListTile(
            title: const Text("memes"),
            leading: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              dashBordController.getImageGallery().whenComplete(() =>
                  dashBordController.userImage(
                      platform: "Meme", place: dashBordController.videos));
            },
          )
        ],
      ),
    );
  }
}
