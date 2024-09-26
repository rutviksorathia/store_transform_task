import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_transform_task/services/connectivity_service.dart';
import 'package:store_transform_task/ui/views/home/home_view.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(ConnectivityController());
      }),
      home: const HomeView(),
    );
  }
}
