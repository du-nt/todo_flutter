import 'package:flutter/material.dart';

import '../model.dart';
import '../todo_view_model.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({super.key, required this.todo});

  final Todo todo;

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  TextEditingController titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo.title;
  }

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel = TodoViewModel(context);

    validator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    void handleEditTodo() {
      if (_formKey.currentState!.validate()) {
        todoViewModel.updateTodo(widget.todo.id, titleController.text);
      }
    }

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            TextFormField(
              autofocus: true,
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigo[50],
                ),
                onPressed: handleEditTodo,
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
