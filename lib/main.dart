import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'package:project2/src/controllers/level_controller.dart';
import 'package:project2/src/services/level_service.dart';
import 'package:project2/src/utils/app_routes.dart';
import 'package:project2/src/utils/app_scroll_behavior.dart';
import 'package:project2/src/widgets/screens/start_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("storage");
  Get.put(LevelService());
  Get.put(LevelController());
  runApp(GetMaterialApp(
      home: StartScreen(),
      scrollBehavior: AppScrollBehavior(),
      initialRoute: AppRoutes.root,
      getPages: AppRoutes.getroutes,
    ));
}