part of 'drag_ball.dart';

typedef OnWidgetPropertyChanged = Function(Size size);
typedef OnIconBallTapped = Function(DragballController controller);

class MeasureProperty extends SingleChildRenderObjectWidget {
  final OnWidgetPropertyChanged onChanged;

  const MeasureProperty({
    Key? key,
    required this.onChanged,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChanged);
  }
}

class MeasureSizeRenderObject extends RenderProxyBox {
  Size? oldSize;
  final OnWidgetPropertyChanged onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    final newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
