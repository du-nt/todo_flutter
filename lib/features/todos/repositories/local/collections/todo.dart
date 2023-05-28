import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class TodoIsar {
  Id id = Isar.autoIncrement;

  late String title;

  bool completed = false;
}
