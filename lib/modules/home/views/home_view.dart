import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_routes.dart';
import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(Routes.CHAT),
          child: const Text('Open Chat'),
        ),
      ),
    );
  }
}