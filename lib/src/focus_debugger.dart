import 'package:flutter/material.dart';
import 'package:flutter_focus_debugger/src/focus_history_pane.dart';
import 'package:flutter_focus_debugger/src/focus_widget_painter.dart';

/// A debugger UI to better understand and track the focus structure in a Flutter
/// app.
///
/// The debugger UI is painted on top of the [child]. The UI includes:
///
///  - Visual bounds around the widget with primary focus.
///  - A translucent pane that shows the history of focus movement.
class FocusDebugger extends StatelessWidget {
  const FocusDebugger({super.key, this.isEnabled = true, required this.child});

  /// Whether to show a focus debugging UI.
  ///
  /// This is an option so that developers can leave this widget in their widget
  /// tree across debug and production builds, and simply toggle the behavior on
  /// and off.
  final bool isEnabled;

  /// The app widget tree (this widget is typically placed at the top of the widget
  /// tree).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      return child;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          FocusWidgetPainter(child: child), //
          Positioned(top: 0, right: 0, bottom: 0, child: FocusHistoryPane()),
        ],
      ),
    );
  }
}
