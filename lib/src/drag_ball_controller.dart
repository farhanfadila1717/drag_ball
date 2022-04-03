part of 'drag_ball.dart';

class DragballController extends ValueNotifier<BallState> {
  DragballController([BallState? value]) : super(value ?? BallState.show);

  void close() {
    value = BallState.close;
  }

  void show() {
    value = BallState.show;
  }

  void showOrHide() {
    if (value == BallState.close) {
      show();
    } else {
      close();
    }
  }

  void update(BallState updateValue) {
    value = updateValue;
  }
}
