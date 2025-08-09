import 'package:flutter/material.dart';
import 'package:flutter_focus_debugger/flutter_focus_debugger.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusDebugger(
      child: MaterialApp(
        home: _ExampleScreen(),
        theme: ThemeData(brightness: Brightness.dark),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _ExampleScreen extends StatefulWidget {
  const _ExampleScreen();

  @override
  State<_ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<_ExampleScreen> {
  final _backButtonFocusNode = FocusNode(debugLabel: "Back Button");
  final _textFieldFocusNode = FocusNode(debugLabel: "Text Field");
  final _buttonFocusNode = FocusNode(debugLabel: "Button");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          focusNode: _backButtonFocusNode,
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Flutter Focus Debugger"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              TextField(
                focusNode: _textFieldFocusNode,
              ),
              ElevatedButton(
                focusNode: _buttonFocusNode,
                onPressed: () {},
                child: Text("Click Me!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
