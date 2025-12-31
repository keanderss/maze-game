import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';

class Joystick extends JoystickComponent {
  Joystick()
    : super(
        knob: CircleComponent(
          radius: 30,
          paint: BasicPalette.red.withAlpha(159).paint(),
        ),
        margin: const EdgeInsets.only(right: 20, bottom: 20),
        background: CircleComponent(
          radius: 100,
          paint: BasicPalette.black.withAlpha(100).paint(),
        ),
      );
}
