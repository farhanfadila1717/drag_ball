import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// {@template OnWidgetSizeChanged}
/// A function type that takes a [Size] parameter and returns no value.
///
/// This function type is typically used as a callback for when the size of a widget changes.
/// {@endtemplate}
typedef OnWidgetSizeChanged = Function(Size size);

/// {@template MeasureSize}
/// A `RenderObject` to get size off widget without `GlobalKey`
/// {@endtemplate}
class MeasureSize extends SingleChildRenderObjectWidget {
  /// {@macro OnWidgetSizeChanged}
  final OnWidgetSizeChanged onChanged;

  /// {@macro MeasureSize}
  const MeasureSize({
    Key? key,
    required this.onChanged,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _MeasureSizeRenderObject(onChanged);
}

/// A `RenderProxyBox` to get size off widget
class _MeasureSizeRenderObject extends RenderProxyBox {
  /// cache old size of widget
  Size? oldSize;

  /// {@macro OnWidgetSizeChanged}
  final OnWidgetSizeChanged onChange;

  _MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
