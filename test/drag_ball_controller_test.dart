import 'package:drag_ball/drag_ball.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final DragballController _controller;

  setUpAll(() {
    _controller = DragballController(BallState.show);
  });

  group('DragballController test', () {
    test('initial state is correct', () {
      expect(_controller.value, BallState.show);
    });

    test('update state from show to hide', () {
      expect(_controller.value, BallState.show);

      _controller.hide();

      expect(_controller.value, BallState.hide);
    });

    test('reversed state', () {
      expect(_controller.value, BallState.hide);
      _controller.reverse();
      expect(_controller.value, BallState.show);
    });
  });
}
