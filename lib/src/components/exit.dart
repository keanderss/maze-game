import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:project2/src/components/maze_game.dart';

class Exit extends BodyComponent<MazeGame> with ContactCallbacks {
  late final Vector2 pos;

  Exit(this.pos);

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..userData = this
      ..type = BodyType.static
      ..position = pos;

    final shape = CircleShape()..radius = 2;
    final fixtureDef = FixtureDef(shape)..isSensor = true;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    game.completeLevel();
    game.incrementScore();
  }
}
