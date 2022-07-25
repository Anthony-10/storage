import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:storage/video.dart';
import 'dashbord_controller.dart';
import 'image/image_display/image_display.dart';
import 'image/image_select/images_select.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final dashBordController = Get.put(DashBordController());

  List<UploadTask> uploadedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload File"),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        spacing: 12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.camera_roll_outlined),
              label: 'Image',
              onTap: () {
                Get.to(() => ImagesSelect());
              }),
          SpeedDialChild(
              child: const Icon(Icons.video_camera_front),
              label: 'video',
              onTap: () {
                Get.to(() => Videos());
              })
        ],
      ),
      body: uploadedTasks == 0
          ? const Center(
              child: Text("Please tap on add button to upload images"))
          : ListView.separated(
              itemBuilder: (context, index) {
                return StreamBuilder<TaskSnapshot>(
                  builder: (context, snapShot) {
                    return snapShot.hasError
                        ? const Text("There is some error in uploading file")
                        : snapShot.hasData
                            ? ListTile(
                                title: Text(
                                    "${snapShot.data?.bytesTransferred}/${snapShot.data?.totalBytes} ${snapShot.data?.state == TaskState.success ? "Completed" : snapShot.data?.state == TaskState.running ? "In Progress" : "Error"}"),
                              )
                            : Container();
                  },
                  stream: uploadedTasks[index].snapshotEvents,
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: uploadedTasks.length,
            ),
    );
  }
}
