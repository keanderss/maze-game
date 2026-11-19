import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:get/get.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:project2/src/components/exit.dart';
import 'package:project2/src/components/joystick.dart';
import 'package:project2/src/components/maze_generator.dart';
import 'package:project2/src/controllers/level_controller.dart';

import 'package:project2/src/widgets/screens/results_screen.dart';
import 'package:project2/src/components/ball.dart';
import 'package:project2/src/components/wall.dart';

class MazeGame extends Forge2DGame with DragCallbacks {
  final LevelController levelController = Get.find<LevelController>();
  var gameFinished = false;
  var timeLeft = 30.0;
  var score = 0;
  late final Ball ball;
  late final Joystick joystick;
  late final MazeGenerator generator;
  final int level;

  MazeGame(this.level)
    : super(
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    joystick = Joystick();
    world.gravity = Vector2(0, 0);
    ball = Ball(Vector2(-35, -25));
    camera.viewport.add(joystick);
    double wallThickness = 2;
    double cellSize = 10;
    world.add(ball);
    world.add(Wall(Vector2(0, -29), Vector2(80, wallThickness)));
    world.add(Wall(Vector2(0, 29), Vector2(80, wallThickness)));
    world.add(Wall(Vector2(-39, 0), Vector2(wallThickness, 60)));
    world.add(Wall(Vector2(39, 0), Vector2(wallThickness, 60)));
    generator = MazeGenerator(8, 6, level, cellSize, wallThickness);
    generator.generate(0, 0);
    generator.build(world);
    world.add(Exit(Vector2(35, 25)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeLeft -= dt;

    if (timeLeft <= 0 && !gameFinished) {
      finishGame();
    }
  }

  void incrementScore() {
    score++;
  }

  void finishGame() {
    gameFinished = true;
    Get.offAll(() => ResultScreen(score: score));
  }

  void completeLevel() {
    levelController.completeLevel(level);
    finishGame();
  }
}
