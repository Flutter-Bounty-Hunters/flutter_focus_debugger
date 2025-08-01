import 'package:flutter/material.dart';
import 'package:flutter_focus_debugger/flutter_focus_debugger.dart';

class FocusWidgetPainter extends StatefulWidget {
  const FocusWidgetPainter({super.key, required this.child});

  final Widget child;

  @override
  State<FocusWidgetPainter> createState() => _FocusWidgetPainterState();
}

class _FocusWidgetPainterState extends State<FocusWidgetPainter> {
  Rect? _focusBounds;

  @override
  void initState() {
    super.initState();

    FocusManager.instance.addListener(_onFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFocusBounds);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);

    super.dispose();
  }

  void _onFocusChange() {
    _updateFocusBounds();
  }

  void _updateFocusBounds() {
    if (!mounted) {
      return;
    }

    setState(() {
      final primaryFocus = FocusManager.instance.primaryFocus;

      _focusBounds = primaryFocus?.context != null ? primaryFocus!.offset & primaryFocus.size : null;
      FfdLogs.widgetPainter.fine("New focus bounds ($primaryFocus): $_focusBounds");
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(foregroundPainter: _FocusBoundsPainter(_focusBounds), child: widget.child);
  }
}

class _FocusBoundsPainter extends CustomPainter {
  const _FocusBoundsPainter(this.bounds);

  final Rect? bounds;

  @override
  void paint(Canvas canvas, Size size) {
    if (bounds == null) {
      return;
    }

    canvas.drawRect(
      bounds!.inflate(2),
      Paint()
        ..color = Colors.purpleAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );
  }

  @override
  bool shouldRepaint(covariant _FocusBoundsPainter oldDelegate) {
    return oldDelegate.bounds != bounds;
  }
}
