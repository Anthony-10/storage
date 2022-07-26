import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashbord_controller.dart';

class Tech extends StatelessWidget {
  Tech({Key? key}) : super(key: key);
  final dashBordController = Get.put(DashBordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tech',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ),
      body: dashBordController.buildExpanded(collections: 'Tech'),
    );
  }
}
