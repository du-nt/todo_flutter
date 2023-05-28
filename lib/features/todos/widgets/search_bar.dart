import 'package:flutter/material.dart';

import '../../../utils/debouncer.dart';
import '../todo_view_model.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key, required this.todoViewModel});

  final TodoViewModel todoViewModel;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleChanged(String value) {
      _debouncer.debounce(() {
        widget.todoViewModel.searchTodo(value);
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: TextField(
        onChanged: handleChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
          ),
        ),
      ),
    );
  }
}
