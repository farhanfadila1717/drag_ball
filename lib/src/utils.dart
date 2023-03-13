import 'package:drag_ball/src/enum.dart';

BallState getBallStateFromString(String ballStateAsString) {
  for (BallState element in BallState.values) {
    if (ballStateAsString.contains(element.name)) {
      return element;
    }
  }
  return BallState.show;
}

extension BallStateExtensions on BallState {
  BallState get reverse =>
      this == BallState.hide ? BallState.show : BallState.hide;

  bool get isHide => this == BallState.hide;
}
