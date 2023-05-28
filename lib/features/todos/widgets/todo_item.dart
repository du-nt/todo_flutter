import 'package:flutter/material.dart';

import '../model.dart';
import '../todo_view_model.dart';
import 'delete_confirm_dialog.dart';
import 'modal_bottom_sheet.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo, required this.todoViewModel});

  final Todo todo;
  final TodoViewModel todoViewModel;

  @override
  Widget build(BuildContext context) {
    void handleOpenEditModal() async {
      final shouldRefresh = await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => ModalBottomSheet(todo: todo));

      if (shouldRefresh == true) {
        todoViewModel.getTodos();
      }
    }

    void handleOpenDeleteConfirm() async {
      final shouldRefresh = await showDialog(
          context: context,
          builder: (BuildContext context) => DeleteConfirmDialog(todo: todo));

      if (shouldRefresh == true) {
        todoViewModel.getTodos();
      }
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: () => todoViewModel.toggleTodo(todo.id),
        leading: Icon(
            todo.completed == true
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: Colors.blueGrey),
        title: Text(
          todo.title,
          style: TextStyle(
              decoration: todo.completed ? TextDecoration.lineThrough : null),
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
              onPressed: handleOpenEditModal,
              icon: const Icon(Icons.edit),
              color: Colors.indigo[300]),
          IconButton(
              onPressed: handleOpenDeleteConfirm,
              icon: const Icon(Icons.delete),
              color: Colors.redAccent),
        ]),
      ),
    );
  }
}
