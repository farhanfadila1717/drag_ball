import 'package:drag_ball/drag_ball.dart';
import 'package:flutter_test/flutter_test.dart';

const _kJsonString = <String, dynamic>{
  'top': 200.0,
  'is_right': true,
  'ball_state': 'show',
};

void main() {
  DragballPosition? sut;

  group('DragballPosition test', () {
    test('load from map', () {
      sut = DragballPosition.fromJSON(_kJsonString);

      expect(sut, isNotNull);
    });

    test('convert to map', () {
      sut = DragballPosition(
        top: 200,
        isRight: true,
        ballState: BallState.show,
      );

      final sutJson = sut!.toMap();

      expect(sutJson, _kJsonString);
    });
  });
}
