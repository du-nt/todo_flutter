import 'package:flutter/material.dart';

class MultiValueListenableBuilder extends StatefulWidget {
  final List<ValueNotifier> valueListenables;
  final Widget Function(BuildContext, List<dynamic>, Widget?) builder;

  const MultiValueListenableBuilder({
    Key? key,
    required this.valueListenables,
    required this.builder,
  }) : super(key: key);

  @override
  MultiValueListenableBuilderState createState() =>
      MultiValueListenableBuilderState();
}

class MultiValueListenableBuilderState
    extends State<MultiValueListenableBuilder> {
  late List<dynamic> _values;

  @override
  void initState() {
    super.initState();
    _values = widget.valueListenables
        .map<dynamic>((notifier) => notifier.value)
        .toList();
    for (var notifier in widget.valueListenables) {
      notifier.addListener(_handleValueChanged);
    }
  }

  @override
  void didUpdateWidget(MultiValueListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenables != widget.valueListenables) {
      for (var notifier in oldWidget.valueListenables) {
        notifier.removeListener(_handleValueChanged);
      }
      _values = widget.valueListenables
          .map<dynamic>((notifier) => notifier.value)
          .toList();
      for (var notifier in widget.valueListenables) {
        notifier.addListener(_handleValueChanged);
      }
    }
  }

  void _handleValueChanged() {
    setState(() {
      _values = widget.valueListenables
          .map<dynamic>((notifier) => notifier.value)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _values, null);
  }

  @override
  void dispose() {
    for (var notifier in widget.valueListenables) {
      notifier.removeListener(_handleValueChanged);
    }
    super.dispose();
  }
}
