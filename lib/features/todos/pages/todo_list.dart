import 'package:flutter/material.dart';
import 'package:todo_app/features/todos/widgets/search_bar.dart';
import 'package:todo_app/features/todos/widgets/todo_item.dart';
import 'package:todo_app/features/todos/widgets/todos_filter.dart';
import '../../../widgets/custom_fab_location.dart';
import '../../../widgets/multi_value_listenable_builder.dart';
import '../model.dart';
import '../todo_view_model.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoViewModel todoViewModel =
        TodoViewModel(context, revalidateOnMount: true);

    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: todoViewModel.navigateToAddPage,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: const CustomFabLocation(0, 120),
        appBar: AppBar(
          title: const Text('Todo list'),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
        ),
        body: MultiValueListenableBuilder(
            valueListenables: [
              todoViewModel.fetched,
              todoViewModel.todos,
            ],
            builder: (context, values, child) {
              final bool isFetched = values[0];
              final List<Todo> todos = values[1];

              return Visibility(
                visible: !isFetched,
                replacement: RefreshIndicator(
                  onRefresh: todoViewModel.getTodos,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SearchBar(todoViewModel: todoViewModel),
                        TodosFilters(todoViewModel: todoViewModel),
                        Visibility(
                          visible: todos.isNotEmpty,
                          replacement: Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Text('No todos',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ),
                          child: Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.only(bottom: 10),
                                itemCount: todos.length,
                                itemBuilder: (context, int index) {
                                  final todo = todos[index];
                                  return TodoItem(
                                      todo: todo, todoViewModel: todoViewModel);
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                child: const Center(child: CircularProgressIndicator()),
              );
            }));
  }
}
