import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'image/image_display/image_display.dart';

class DashBordController extends GetxController {
  final image = [].obs;
  final videos = [].obs;
  List fileURLList = [];
  var fileURL;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final customCacheManager = CacheManager(
    Config(
      'customCachKey',
      stalePeriod: const Duration(days: 20),
      maxNrOfCacheObjects: 100,
    ),
  );

  Future<void> getImageGallery() async {
    image.clear();
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (pickedFile != null) {
      pickedFile.files.forEach((selectedFile) {
        final File file = File(selectedFile.path!);
        image.add(file);
        print('At the drawerImage$image');
      });
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
      print('Error' 'No image selected');
    }
  }

  Future<void> getVideoGallery(ImageSource imageSource) async {
    videos.clear();
    final FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );
    if (pickedFile != null) {
      pickedFile.files.forEach((selectedFile) {
        final File video = File(selectedFile.path!);
        videos.add(video);
        print('At the drawerImage$videos');
      });
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
      print('Error' 'No image selected');
    }
  }

  Future<void> userImage({required String platform, required var place}) async {
    fileURLList.clear();
    print(
        '????????????????????????????????userImage>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print(
        "$image, $videos,GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
    try {
      if (image.isNotEmpty || videos.isNotEmpty) {
        for (var file in place) {
          final ref = firebase_storage.FirebaseStorage.instance
              .ref()
              .child("$platform/${DateTime.now().toString()}");
          final result = await ref.putFile(file);
          fileURL = await result.ref.getDownloadURL();

          fileURLList.add(fileURL);
          /*image.clear();*/
          print('$fileURLList>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');
        }
        image.clear();
        print('$fileURLList>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>pppppppp');
        for (var element in fileURLList) {
          userProducts(url: element, collections: platform);
        }
      } else {
        print('sddddddddddddddddddddddddddddddddddddddddddddddddddd');
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Uploading Image",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> userProducts(
      {required var url, required var collections}) async {
    print('$url>>>>>>>>>>>>>>>>>>>>>>>>>>>>jjj');
    try {
      await _fireStore.collection(collections).add({
        'Url': url,
      }).whenComplete(() => Get.to(() => const ImageDisplay()));
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error Adding User Info",
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      rethrow;
    }
  }

  buildExpanded({required String collections}) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(collections).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Check your connection"),
              );
            } else {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.65),
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.28,
                          width: Get.width * 0.5,
                          child: Card(
                            child: CachedNetworkImage(
                              cacheManager: customCacheManager,
                              imageUrl:
                                  snapshot.data!.docs[index]['Url'].toString(),
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Container(
                                color: Colors.black12,
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.black12,
                                child:
                                    const Icon(Icons.error, color: Colors.red),
                              ),
                            ),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
            return const Text("Loding...");
          } else {
            return const Center(child: Text("Loding..."));
          }
        });
  }
}
