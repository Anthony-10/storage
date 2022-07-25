import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashbord_controller.dart';

class Meme extends StatelessWidget {
  final dashBordController = Get.put(DashBordController());

  Meme({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: Padding(
              padding:
                  EdgeInsets.only(top: Get.height * .06, left: Get.width * .09),
              child: const Text(
                'Meme',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )),
            dashBordController.buildExpanded(collections: 'Meme'),
          ],
        ),
      ),
    );
  }
}
