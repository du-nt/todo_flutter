import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/todo_view_model.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel = TodoViewModel(context);

    validator(value) {
      if (value == null || value.isEmpty) {
        return 'Please enter some text';
      }
      return null;
    }

    void handleAddTodo() {
      if (_formKey.currentState!.validate()) {
        final title = titleController.text;
        todoViewModel.createTodo(title);
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text('Add new todo'), centerTitle: true),
        body: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(20), children: [
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
                onPressed: handleAddTodo,
                child: const Text('Add'))
          ]),
        ));
  }
}
