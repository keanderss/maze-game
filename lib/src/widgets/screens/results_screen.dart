import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  const ResultScreen({super.key, required this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Score: $score !",
                style: TextStyle(fontSize: 48)),
            Padding(
              padding: EdgeInsets.all(16),
            ),
            ElevatedButton(
              child: Text(
                "Level select",
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