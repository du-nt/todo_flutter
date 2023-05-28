import 'package:flutter/material.dart';

import '../model.dart';
import '../todo_view_model.dart';

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel = TodoViewModel(context);

    return AlertDialog(
      title: const Text('Do you want to delete this item?'),
      content: Text(todo.title),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => todoViewModel.deleteTodo(todo.id),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
