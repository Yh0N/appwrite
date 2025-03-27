import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appwrite/appwrite.dart';

import 'package:users/core/config/app_config.dart';
import 'package:users/presentation/pages/home_page.dart';
import 'package:users/controllers/user_controller.dart';
import 'package:users/data/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = AppwriteConfig.initClient();
  final databases = Databases(client);

  Get.put(UserRepository(databases));
  Get.put(UserController(repository: Get.find()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appwrite Flutter App con GetX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
