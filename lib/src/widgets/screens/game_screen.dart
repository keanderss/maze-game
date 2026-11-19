import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';

import 'package:project2/src/components/maze_game.dart';
import 'package:project2/src/controllers/level_controller.dart';

class GameScreen extends StatelessWidget {
  final LevelController levelController = Get.find<LevelController>();
  GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MazeGame(levelController.currentLevel),
    );
  }
}