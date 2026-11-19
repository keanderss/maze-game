import 'package:hive_ce/hive.dart';

class LevelService {
  final box = Hive.box("storage");
  late final String key;

  LevelService() {
    key = "levels";
    if (box.get(key) == null) {
      box.put(key, []);
    }
  }

  List<int> get storage => box.get(key).map<int>((e) => e as int).toList();

  void save(Set<int> completedLevels) {
    box.put(key, completedLevels.toList());
  }
}
