import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:project2/src/components/maze_game.dart';

class Ball extends BodyComponent<MazeGame>
    with HasGameRef<MazeGame>, ContactCallbacks {
  late final Vector2 pos;

  Ball(this.pos);

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.dynamic
      ..position = pos;

    final shape = CircleShape()..radius = 1;
    final fixtureDef = FixtureDef(shape)..restitution = 0.5;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (gameRef.joystick.direction) {
      case JoystickDirection.up:
        body.applyLinearImpulse(Vector2(0, -1));
      case JoystickDirection.upRight:
        body.applyLinearImpulse(Vector2(1, -1));
      case JoystickDirection.right:
        body.applyLinearImpulse(Vector2(1, 0));
      case JoystickDirection.downRight:
        body.applyLinearImpulse(Vector2(1, 1));
      case JoystickDirection.down:
        body.applyLinearImpulse(Vector2(0, 1));
      case JoystickDirection.downLeft:
        body.applyLinearImpulse(Vector2(-1, 1));
      case JoystickDirection.left:
        body.applyLinearImpulse(Vector2(-1, 0));
      case JoystickDirection.upLeft:
        body.applyLinearImpulse(Vector2(-1, -1));
      default:
        break;
    }
  }
}
