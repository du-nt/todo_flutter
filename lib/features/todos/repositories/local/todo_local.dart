import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/features/todos/repositories/todo_repository.dart';

import '../../model.dart';
import '../../todo_view_model.dart';
import 'collections/todo.dart';

class LocalTodoRepository extends TodoRepository {
  late Future<Isar> db;

  LocalTodoRepository() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();

      return await Isar.open(
        [TodoIsarSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<List<Todo>> getTodos(String value, TodoType type) async {
    final isar = await db;
    final todosQuery = isar.todoIsars.filter().titleContains(value);

    List<Todo> mapTodosToList(List<TodoIsar> todos) {
      return todos
          .map((todoIsar) => Todo(
                id: todoIsar.id.toString(),
                title: todoIsar.title,
                completed: todoIsar.completed,
              ))
          .toList();
    }

    if (type == TodoType.all) {
      final todos = await todosQuery.findAll();
      return mapTodosToList(todos);
    } else if (type == TodoType.active) {
      final todos = await todosQuery.completedEqualTo(false).findAll();
      return mapTodosToList(todos);
    } else {
      final todos = await todosQuery.completedEqualTo(true).findAll();
      return mapTodosToList(todos);
    }
  }

  @override
  Future<void> createTodo(String title) async {
    final todo = TodoIsar()
      ..title = title
      ..completed = false;

    final isar = await db;
    await isar.writeTxn(() async {
      await isar.todoIsars.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(String idString) async {
    final isar = await db;
    final id = int.parse(idString);
    await isar.writeTxn(() async {
      await isar.todoIsars.delete(id);
    });
  }

  @override
  Future<void> updateTodo(String idString, String title) async {
    final isar = await db;
    final id = int.parse(idString);
    final existingTodo = await isar.todoIsars.get(id);

    if (existingTodo != null) {
      existingTodo.title = title;
      await isar.writeTxn(() async {
        await isar.todoIsars.put(existingTodo);
      });
    }
  }

  @override
  Future<void> toggleTodo(String idString) async {
    final isar = await db;
    final id = int.parse(idString);
    final existingTodo = await isar.todoIsars.get(id);

    if (existingTodo != null) {
      existingTodo.completed = !existingTodo.completed;
      await isar.writeTxn(() async {
        await isar.todoIsars.put(existingTodo);
      });
    }
  }
}
