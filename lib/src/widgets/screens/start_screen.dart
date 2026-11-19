import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("AMazeGame!", style: TextStyle(fontSize: 48)),
            Padding(
              padding: EdgeInsets.all(16),
            ),
            ElevatedButton(
              child: Text(
                "Level Select",
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => Get.toNamed("/levels"),
            ),
          ],
        ),
      ),
    );
  }
}