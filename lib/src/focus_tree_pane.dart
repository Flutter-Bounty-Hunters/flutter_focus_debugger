import 'package:flutter/material.dart';

class FocusTreePane extends StatefulWidget {
  const FocusTreePane({super.key, required this.child});

  final Widget child;

  @override
  State<FocusTreePane> createState() => _FocusTreePaneState();
}

class _FocusTreePaneState extends State<FocusTreePane> {
  @override
  void initState() {
    super.initState();

    FocusManager.instance.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    // TODO:
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
