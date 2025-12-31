import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:project2/src/widgets/screens/level_screen.dart';
import 'package:project2/src/widgets/screens/start_screen.dart';

class AppRoutes {
  static const root = "/";

  static final getroutes = [
    GetPage(name: root, page: () => StartScreen()),
    GetPage(name: "/levels", page: () => LevelScreen()),
  ];
}
