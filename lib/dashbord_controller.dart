import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  Future<void> getImageGallery(ImageSource imageSource) async {
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

  Future<void> userImage({required String platform}) async {
    fileURLList.clear();
    print(
        '????????????????????????????????userImage>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print(
        "$image, $videos,GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG");
    try {
      if (image.isNotEmpty || videos.isNotEmpty) {
        image.forEach((file) async {
          final ref = firebase_storage.FirebaseStorage.instance
              .ref()
              .child("$platform/${DateTime.now().toString()}");
          final result = await ref.putFile(file);
          fileURL = await result.ref.getDownloadURL();

          fileURLList.add(fileURL);
          image.clear();
          print('$fileURLList>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.');
        });
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

  Future<void> userProducts({
    var url,
  }) async {
    print('$url>>>>>>>>>>>>>>>>>>>>>>>>>>>>jjj');
    try {
      await _fireStore.collection("Images").doc().set({
        'Url': url,
      });
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
}
