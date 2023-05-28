import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/todo_view_model.dart';

class TodosFilters extends StatefulWidget {
  const TodosFilters({super.key, required this.todoViewModel});

  final TodoViewModel todoViewModel;

  @override
  State<TodosFilters> createState() => _TodosFiltersState();
}

class _TodosFiltersState extends State<TodosFilters> {
  int _value = 0;
  List<Filter> types = [
    Filter(label: 'All', value: TodoType.all),
    Filter(label: 'Active', value: TodoType.active),
    Filter(label: 'Completed', value: TodoType.completed),
  ];

  @override
  Widget build(BuildContext context) {
    void handleSelect(int index) {
      setState(() {
        _value = index;
      });
      widget.todoViewModel.filterTodo(types[index].value);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          types.length,
          (index) => ActionChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                label: Text(types[index].label),
                onPressed: () {
                  handleSelect(index);
                },
                backgroundColor:
                    _value == index ? Colors.orange[300] : Colors.grey[300],
              )),
    );
  }
}
