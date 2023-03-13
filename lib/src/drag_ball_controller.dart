import 'package:drag_ball/drag_ball.dart';
import 'package:flutter/material.dart';

/// {@template DragballController}
/// The DragballController class extends ValueNotifier<BallState> and
/// provides methods for managing the state of `Dragball`.
/// {@endtemplate}
class DragballController extends ValueNotifier<BallState> {
  /// {@macro DragballController}
  DragballController([BallState value = BallState.show]) : super(value);

  /// Sets the ball state to BallState.hide and notifies any listeners of the change.
  void hide() {
    value = BallState.hide;
    notifyListeners();
  }

  /// Sets the ball state to BallState.show and notifies any listeners of the change.
  void show() {
    value = BallState.show;
    notifyListeners();
  }

  /// Toggles the ball state between BallState.hide and BallState.show and
  /// notifies any listeners of the change.
  void reverse() => value == BallState.hide ? show() : hide();
}
