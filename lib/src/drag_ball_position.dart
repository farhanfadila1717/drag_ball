import 'dart:convert';
import 'package:drag_ball/drag_ball.dart';

class DragballPosition {
  final double top;
  final bool isRight;
  final BallState ballState;

  const DragballPosition({
    required this.top,
    required this.isRight,
    required this.ballState,
  });

  const DragballPosition.defaultPosition()
      : top = 200.0,
        isRight = true,
        ballState = BallState.show;

  DragballPosition copyWith({
    double? top,
    bool? isRight,
    BallState? ballState,
  }) =>
      DragballPosition(
        top: top ?? this.top,
        isRight: isRight ?? this.isRight,
        ballState: ballState ?? this.ballState,
      );

  factory DragballPosition.fromJSON(Map<String, dynamic> json) =>
      DragballPosition(
        top: json['top'] ?? 100,
        isRight: json['is_right'] ?? false,
        ballState: getBallStateFromString(json['ball_state']),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'top': top,
      'is_right': isRight,
      'ball_state': ballState.name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant DragballPosition other) {
    if (identical(this, other)) return true;

    return other.top == top &&
        other.isRight == isRight &&
        other.ballState == ballState;
  }

  @override
  int get hashCode => top.hashCode ^ isRight.hashCode ^ ballState.hashCode;

  @override
  String toString() =>
      'DragballPosition(top: $top, isRight: $isRight, ballState: $ballState)';
}
