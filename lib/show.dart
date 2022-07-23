import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashbord_controller.dart';

class Show extends StatelessWidget {
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
                'Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Images")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Check your connection"),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        cacheManager: dashBordController
                                            .customCacheManager,
                                        imageUrl: snapshot
                                            .data!.docs[index]['url']
                                            .toString(),
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.black12,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.black12,
                                          child: const Icon(Icons.error,
                                              color: Colors.red),
                                        ),
                                      ),
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                      return const Text("Loding...");
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
