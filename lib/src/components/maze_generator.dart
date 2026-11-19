import 'dart:math';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:project2/src/components/wall.dart';

// 0 = not visited
// 1 = open north
// 2 = open south
// 3 = open west
// 4 = open east
// 5 = dead end

class MazeGenerator {
  final int width, height;
  final List<List<MazeCell>> mazeWalls;
  final List<List<int>> mazeGraph;
  final List<List<bool>> verticalWalls;
  final List<List<bool>> horizontalWalls;
  final double cellSize;
  final double wallThickness;
  final Random random;

  MazeGenerator(
    this.width,
    this.height,
    int seed,
    this.cellSize,
    this.wallThickness,
  ) : mazeWalls = initialize(width, height, cellSize, wallThickness),
      mazeGraph = List.generate(height, (_) => List.filled(width, 0)),
      random = Random(seed),
      verticalWalls = List.generate(
        height,
        (_) => List.filled(width - 1, true),
      ),
      horizontalWalls = List.generate(
        height - 1,
        (_) => List.filled(width, true),
      );

  void generate(int startx, int starty) {
    List<int> frontier = [];
    List<List<int>> walls = [];
    // 1. Start with a grid full of walls.
    // 2. Pick a cell, mark it as part of the maze.
    //    Add the walls of the cell to the wall list.
    int x = startx;
    int y = starty;
    walls.add([x, y, 0]);
    while (walls.isNotEmpty) {
      // Check surrounding cells if they are visited?
      // -> Wall list
      // Check North
      if (y > 0) {
        if (mazeGraph[y - 1][x] == 0) {
          walls.add([x, y - 1, 2]);
          frontier.add(1);
        }
      }
      // Check South
      if (y < height - 1) {
        if (mazeGraph[y + 1][x] == 0) {
          walls.add([x, y + 1, 1]);
          frontier.add(2);
        }
      }
      // Check West
      if (x > 0) {
        if (mazeGraph[y][x - 1] == 0) {
          walls.add([x - 1, y, 4]);
          frontier.add(3);
        }
      }
      // Check East
      if (x < width - 1) {
        if (mazeGraph[y][x + 1] == 0) {
          walls.add([x + 1, y, 3]);
          frontier.add(4);
        }
      }
      if (frontier.isNotEmpty) {
        int index = random.nextInt(frontier.length);
        mazeGraph[y][x] = frontier[index];
        walls.removeWhere((cell) => cell[0] == x && cell[1] == y);
        switch (frontier[index]) {
          case 1:
            if (y < height - 1) horizontalWalls[y][x] = false;
            y -= 1;
            mazeWalls[y][x].removeHorizontal();
            break;
          case 2:
            if (y < height - 1) horizontalWalls[y][x] = false;
            mazeWalls[y][x].removeHorizontal();
            y += 1;
            break;
          case 3:
            if (x < width - 1) verticalWalls[y][x] = false;
            x -= 1;
            mazeWalls[y][x].removeVertical();
            break;
          case 4:
            if (x < width - 1) verticalWalls[y][x] = false;
            mazeWalls[y][x].removeVertical();
            x += 1;
            break;
          default:
            break;
        }
        // 3. While there are walls in the list.
        //      1.  Pick a random wall from the list.
        //      2.  If only one of the cells that the wall divides is
        //          visited, then:
        //          1.  Make the wall a passage and mark the
        //              unvisited cell as part of the maze.
        //          2.  Add the neighboring walls of the cell to the
        //              wall list.
        //      3.  Remove the wall from the list.
      } else {
        walls.removeWhere((cell) => cell[0] == x && cell[1] == y);
        if (walls.isNotEmpty) {
          mazeGraph[y][x] = 5;
          x = walls[0][0];
          y = walls[0][1];
          int origin = walls.firstWhere(
            (cell) => cell[0] == x && cell[1] == y,
          )[2];
          switch (origin) {
            case 1:
              mazeWalls[y - 1][x].removeHorizontal();
              break;
            case 2:
              mazeWalls[y][x].removeHorizontal();
              break;
            case 3:
              mazeWalls[y][x - 1].removeVertical();
              break;
            case 4:
              mazeWalls[y][x].removeVertical();
              break;
            default:
          }
        } else {
          mazeGraph[y][x] = 6;
        }
      }
      frontier = [];
    }
  }

  void build(Forge2DWorld world) {
    for (int y = 0; y < mazeWalls.length; y++) {
      for (int x = 0; x < mazeWalls[y].length; x++) {
        mazeWalls[y][x].getWalls().forEach((wall) => world.add(wall));
      }
    }
  }

  static List<List<MazeCell>> initialize(
    int width,
    int height,
    cellSize,
    wallThickness,
  ) {
    List<List<MazeCell>> maze = [];
    List<MazeCell> row = [];
    double xOffset = width / 2 - width / 16;
    double yOffset = height / 2 - height / 12;
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        Wall horizontal = Wall(
          Vector2((x - xOffset) * cellSize, (y - yOffset + 0.5) * cellSize),
          Vector2(cellSize / 1.44, wallThickness),
        );
        Wall vertical = Wall(
          Vector2((x - xOffset + 0.5) * cellSize, (y - yOffset) * cellSize),
          Vector2(wallThickness, cellSize / 1.44),
        );
        row.add(MazeCell(vertical, horizontal));
      }
      maze.add(row);
      row = [];
    }
    return maze;
  }
}

class MazeCell {
  Wall? vertical;
  Wall? horizontal;
  MazeCell(this.vertical, this.horizontal);

  void removeHorizontal() {
    if (horizontal != null) {
      horizontal = null;
    }
  }

  void removeVertical() {
    if (vertical != null) {
      vertical = null;
    }
  }

  List<Wall> getWalls() {
    List<Wall> walls = [];
    if (vertical != null) {
      walls.add(vertical as Wall);
    }
    if (horizontal != null) {
      walls.add(horizontal as Wall);
    }
    return walls;
  }
}
