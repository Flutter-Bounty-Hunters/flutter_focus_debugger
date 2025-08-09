## 0.1.3
### Aug 9, 2025
Update README - replace video with gif.

## 0.1.2
### Aug 9, 2025
Update README with video, screenshots, and getting started.

## 0.1.1
### Aug 9, 2025
 * FIX: Debug focus bounds now correctly account for `FocusDebugger` sitting somewhere other than the screen origin.
 * FEATURE: Debug focus bounds animate from one widget to another (can be turned off).
 * FEATURE: `FocusDebugger` can show/hide focus bounds and focus history, independently.
 * ADJUSTMENT: Created an `example` app.

## 0.1.0
Initial Release:
 * `FocusDebugger`: A widget that surrounds an entire app and paints focus debugging visuals.
 * `FocusWidgetPainter`: Paints the global bounds around the widget with primary focus.
 * `FocusHistoryPane`: A pane that displays a full history of focus movement during an app run.
 * `FfdLogs`: Logger used within `flutter_focus_debugger`.
