import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashbord_controller.dart';

class ImagesSelect extends StatelessWidget {
  final dashBordController = Get.put(DashBordController());

  ImagesSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: GridView.count(
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  dashBordController.getImageGallery().whenComplete(() =>
                      dashBordController.userImage(
                          platform: "Tech", place: dashBordController.image));
                },
                child: Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Text(
                      "Tech",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  dashBordController.getImageGallery().whenComplete(() =>
                      dashBordController.userImage(
                          platform: "Meme", place: dashBordController.image));
                },
                child: Container(
                  color: Colors.grey,
                  child: const Center(
                    child: Text(
                      "Memes",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ) /*ListView(
          children: [
            ListTile(
              title: const Text(
                "Tech",
                style: TextStyle(fontSize: 20),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                dashBordController.getImageGallery().whenComplete(() =>
                    dashBordController.userImage(
                        platform: "Tech", place: dashBordController.image));
              },
            ),
            ListTile(
              title: const Text(
                "Memes",
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onTap: () {
                dashBordController.getImageGallery().whenComplete(() =>
                    dashBordController.userImage(
                        platform: "Meme", place: dashBordController.image));
              },
            )
          ],
        ),*/
          ),
    );
  }
}
