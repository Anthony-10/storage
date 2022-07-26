import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage/image/image_display/Meme.dart';
import 'package:storage/image/image_display/tech.dart';
import 'package:storage/upload_screen.dart';

class ImageDisplay extends StatelessWidget {
  const ImageDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const UploadScreen());
              },
              icon: const Icon(Icons.camera))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: GridView.count(
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => Tech()),
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
                onTap: () => Get.to(() => Meme()),
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
          )
          /*ListView(
          children: [
            ListTile(
              title: const Text(
                "Tech",
                style: TextStyle(fontSize: 20),
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                Get.to(() => Tech());
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: const Text(
                "memes",
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              onTap: () {
                Get.to(() => Meme());
              },
            )
          ],
        ),*/
          ),
    );
  }
}
