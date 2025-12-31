import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project2/src/controllers/level_controller.dart';
import 'package:project2/src/utils/breakpoints.dart';
import 'package:project2/src/widgets/components/level_button.dart';

class LevelScreen extends StatelessWidget {
  final LevelController levelController = Get.find<LevelController>();
  LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = Iterable.generate(levelController.totalLevels).expand((
      level,
    ) {
      return [LevelButton(level)];
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Level Select"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.toNamed("/"),
        ),
      ),
      body: Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > Breakpoints.tablet) {
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 1500),
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.8,
                    ),
                    children: [...levels],
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: Breakpoints.mobileL),
                  child: ListView(children: [...levels]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
