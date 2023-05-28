import 'package:flutter/material.dart';

import 'model.dart';
import 'pages/add_todo.dart';
import 'repositories/local/todo_local.dart';
import 'repositories/todo_repository.dart';

enum TodoType {
  all,
  active,
  completed,
}

class Filter {
  String label;
  TodoType value;

  Filter({required this.label, required this.value});
}

class TodoViewModel {
  final TodoRepository _repository = LocalTodoRepository();

  final _todos = ValueNotifier<List<Todo>>([]);
  final _loading = ValueNotifier<bool>(true);
  final _fetched = ValueNotifier<bool>(false);

  final _name = ValueNotifier<String>('');
  final _type = ValueNotifier<TodoType>(TodoType.all);

  final BuildContext context;

  ValueNotifier<List<Todo>> get todos => _todos;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> get fetched => _fetched;

  ValueNotifier<String> get name => _name;
  ValueNotifier<TodoType> get type => _type;

  TodoViewModel(this.context, {bool revalidateOnMount = false}) {
    if (revalidateOnMount) {
      getTodos();
    }
  }

  Future<void> getTodos() async {
    _loading.value = true;
    final todos = await _repository.getTodos(_name.value, _type.value);
    _todos.value = todos;
    await Future.delayed(const Duration(seconds: 1));
    _loading.value = false;
    _fetched.value = true;
  }

  Future<void> createTodo(String title) async {
    await _repository.createTodo(title);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> deleteTodo(String id) async {
    await _repository.deleteTodo(id);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> updateTodo(String id, String title) async {
    await _repository.updateTodo(id, title);
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> toggleTodo(String id) async {
    await _repository.toggleTodo(id);
    getTodos();
  }

  Future<void> searchTodo(String value) async {
    _name.value = value;
    getTodos();
  }

  Future<void> filterTodo(TodoType type) async {
    _type.value = type;
    getTodos();
  }

  void navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodo(),
    );
    final shouldRefresh = await Navigator.push(context, route);

    if (shouldRefresh == true) {
      getTodos();
    }
  }
}
