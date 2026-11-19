import 'package:get/get.dart';
import 'package:project2/src/services/level_service.dart';

class LevelController {
  final LevelService service = Get.find<LevelService>();
  final int _totalLevels;
  final RxSet<int> _completedLevels;
  final RxInt _currentLevel;

  LevelController({int levelCount = 99}) : _totalLevels=levelCount, _completedLevels = <int>{}.obs, _currentLevel = 0.obs {
    _completedLevels.addAll(service.storage);
  }

  void setLevel(int level) {
    _currentLevel.value = level;
  }

  void completeLevel(int level) {
    _completedLevels.add(level);
    service.save(_completedLevels);
  }

  List<int> get getCompleted => _completedLevels.toList();

  int get totalLevels => _totalLevels;

  int get currentLevel => _currentLevel.value;
}