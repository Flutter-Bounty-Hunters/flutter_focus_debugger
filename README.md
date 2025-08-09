# Flutter Focus Debugger
Tools for tracing and debugging focus changes in Flutter.

<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/b153485a-21db-4470-a245-cbd076d9d224" width="650" />
</p>
<br>
  
**Focus Bounds:** See the global bounds of the currently focused widget.

**Focus History:** See a list of all focus changes since the start of the app.

<br><br>

### Getting Started
Wrap your widget tree with a `FocusDebugger`:

```dart
FocusDebugger(
  child: MaterialApp(),
);
```
<br><br>

<h3 align="center">Examples</h3>
<p align="center"><img width="500" alt="focused-widget-debug-border" src="https://github.com/user-attachments/assets/c84d9428-6804-451f-a3cc-a254b2337a42" /></p>

<br>

<p align="center"><img width="500" alt="focus-border-animation" src="https://github.com/user-attachments/assets/c575cb54-23d6-4ffa-a994-2292f45979eb" /></p>
