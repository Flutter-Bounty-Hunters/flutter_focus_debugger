import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_debugger/flutter_focus_debugger.dart';
import 'package:flutter_test_goldens/flutter_test_goldens.dart';
import 'package:flutter_test_robots/flutter_test_robots.dart';

void main() {
  FfdLogs.initLoggers({FfdLogs.widgetPainter});

  testGoldenSceneOnMac('Focused widget has debug border', (tester) async {
    await Timeline(
      'Focused widget has debug border',
      fileName: 'focused-widget-debug-border',
      layout: AnimationTimelineSceneLayout(
        rowBreakPolicy: AnimationTimelineRowBreak.afterMaxColumnCount(2),
      ),
      windowSize: const Size(250, 250),
    )
        .setupWithWidget(
          FocusDebugger(
            isEnabled: true,
            animateFocusBorderChanges: false,
            showFocusHistory: false,
            child: _TestScreen(),
          ),
        )
        .takePhoto("Idle")
        .modifyScene((tester, _) => tester.pressTab())
        .settle()
        .takePhoto("Focused on back button")
        .modifyScene((tester, _) => tester.pressTab())
        .settle()
        .takePhoto("Focused on text field")
        .modifyScene((tester, _) => tester.pressTab())
        .settle()
        .takePhoto("Focused on button")
        .run(tester);
  });

  testGoldenSceneOnMac('Focused border can animate to new bounds', (tester) async {
    await Timeline(
      'Focused border can animate',
      fileName: 'focus-border-animation',
      layout: AnimationTimelineSceneLayout(
        rowBreakPolicy: AnimationTimelineRowBreak.afterMaxColumnCount(1),
      ),
      windowSize: const Size(250, 250),
    )
        .setupWithWidget(
          FocusDebugger(
            isEnabled: true,
            showFocusHistory: false,
            child: _TestScreen(),
          ),
        )
        .modifyScene((tester, _) => tester.pressTab())
        .settle()
        .takePhoto("Initial Focus")
        .modifyScene((tester, _) => tester.sendKeyEvent(LogicalKeyboardKey.tab, platform: "macos"))
        .takePhotos(6, const Duration(milliseconds: 50))
        .run(tester);
  });
}

class _TestScreen extends StatelessWidget {
  const _TestScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: Text("Title"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              TextField(),
              ElevatedButton(
                focusNode: FocusNode(),
                onPressed: () {},
                child: Text("Click Me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
