import 'package:flutter/material.dart' hide LinearGradient;
import 'package:flutter/rendering.dart';

class FocusHistoryPane extends StatefulWidget {
  const FocusHistoryPane({super.key, this.width = 200});

  final double width;

  @override
  State<FocusHistoryPane> createState() => _FocusHistoryPaneState();
}

class _FocusHistoryPaneState extends State<FocusHistoryPane> {
  final _history = <String>[];

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
    final focusedNode = FocusManager.instance.primaryFocus;
    final name = _getFocusName(focusedNode);
    if (_history.lastOrNull == name) {
      return;
    }

    setState(() {
      _history.add(name);
    });
  }

  String _getFocusName(FocusNode? focusNode) {
    if (focusNode == null) {
      return "None";
    }

    return focusNode.debugLabel ?? "${focusNode.hashCode}";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ShaderMask(
        shaderCallback: _fadeOutTopToBottom,
        child: ColoredBox(
          color: Colors.black.withValues(alpha: 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "FOCUS HISTORY",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final historyIndex = _history.length - index - 1;
                    final name = _history[historyIndex];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text("$historyIndex: $name", style: TextStyle(color: Colors.purpleAccent)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Shader _fadeOutTopToBottom(Rect bounds) {
    return LinearGradient(
      colors: [Colors.white, Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.3, 0.6],
    ).createShader(bounds);
  }
}
