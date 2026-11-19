import 'package:flame_forge2d/flame_forge2d.dart';

class Wall extends BodyComponent {
  final Vector2 size;
  final Vector2 position;
  Wall(this.position, this.size);

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = position;

    final shape = PolygonShape()..setAsBoxXY(size.x, size.y);
    final fixtureDef = FixtureDef(shape)..friction = 0.8;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}