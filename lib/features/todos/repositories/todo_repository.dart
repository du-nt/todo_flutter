import '../model.dart';
import '../todo_view_model.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos(String value, TodoType type);
  Future<void> createTodo(String title);
  Future<void> updateTodo(String idString, String title);
  Future<void> deleteTodo(String idString);
  Future<void> toggleTodo(String idString);
}
