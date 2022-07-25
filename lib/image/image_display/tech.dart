import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashbord_controller.dart';

class Tech extends StatelessWidget {
  Tech({Key? key}) : super(key: key);
  final dashBordController = Get.put(DashBordController());

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
                'Tech',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )),
            dashBordController.buildExpanded(collections: 'Tech'),
          ],
        ),
      ),
    );
  }
}
