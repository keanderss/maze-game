import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project2/src/controllers/level_controller.dart';
import 'package:project2/src/widgets/screens/game_screen.dart';

class LevelButton extends StatelessWidget {
  final LevelController levelController = Get.find<LevelController>();
  final int level;
  LevelButton(this.level, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: CupertinoButton.tinted(
        child: Container(
          constraints: BoxConstraints(maxHeight: 300),
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Flexible(fit: FlexFit.tight, child: Text("Level ${level + 1}", style: TextStyle(fontSize: 32))),
              if (levelController.getCompleted.contains(level))
                const Flexible(fit: FlexFit.tight, child: Text("Completed!")),
            ],
          ),
        ),
        onPressed: () {
          levelController.setLevel(level);
          Get.to(GameScreen());
        },
      ),
    );
  }
}
