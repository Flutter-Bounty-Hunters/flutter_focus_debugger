import 'package:flutter/material.dart';
import 'package:flutter_focus_debugger/flutter_focus_debugger.dart';

class FocusWidgetPainter extends StatefulWidget {
  const FocusWidgetPainter({
    super.key,
    this.animateBounds = true,
    required this.child,
  });

  final bool animateBounds;

  final Widget child;

  @override
  State<FocusWidgetPainter> createState() => _FocusWidgetPainterState();
}

class _FocusWidgetPainterState extends State<FocusWidgetPainter> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  FocusNode? _focusedNode;

  Rect? _boundsFrom;
  Rect? _boundsTo;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    FocusManager.instance.addListener(_onFocusChange);

    WidgetsBinding.instance.addPostFrameCallback((_) => _updateFocusBounds);
  }

  @override
  void dispose() {
    FocusManager.instance.removeListener(_onFocusChange);

    _animationController.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Note: Focus change callbacks run immediately, which means there are some
      // unusual moments, such as app launch, where this call might run at a time that
      // layouts are dirty. To ensure we don't inspect dirty layouts, we run at the end
      // of the frame.
      _updateFocusBounds();
    });
  }

  void _updateFocusBounds() {
    if (!mounted) {
      return;
    }

    setState(() {
      final primaryFocus = FocusManager.instance.primaryFocus;

      if (primaryFocus == null || primaryFocus.context == null) {
        _boundsFrom = null;
        _boundsTo = null;
        _animationController.stop();
        return;
      }

      // Animate, if desired, and if the focused widget has changed. We don't
      // want to animate if the same widget is focused, because the widget might
      // animate its own size and we don't want to lag behind an animation.
      final shouldAnimate = widget.animateBounds && primaryFocus != _focusedNode;
      _focusedNode = primaryFocus;

      final thisDebuggerOffset = (context.findRenderObject() as RenderBox).globalToLocal(Offset.zero);
      _boundsFrom = _boundsTo;
      _boundsTo = primaryFocus.rect.translate(thisDebuggerOffset.dx, thisDebuggerOffset.dy);
      FfdLogs.widgetPainter.fine("New focus bounds ($primaryFocus): $_boundsTo, bounds from: $_boundsFrom");

      if (shouldAnimate) {
        _animationController.forward(from: 0);
      } else {
        _boundsFrom = _boundsTo;
        _animationController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: _FocusBoundsPainter(
            Rect.lerp(
              _boundsFrom,
              _boundsTo,
              Curves.easeInOutCubic.transform(_animationController.value),
            ),
          ),
          willChange: _animationController.isAnimating,
          child: child,
        );
      },
      child: widget.child,
    );
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
      bounds!.inflate(0),
      Paint()
        ..color = Colors.purpleAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant _FocusBoundsPainter oldDelegate) {
    return oldDelegate.bounds != bounds;
  }
}
