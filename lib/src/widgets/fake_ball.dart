import 'package:flutter/material.dart';

import 'measure_size.dart';

/// {@template fake_ball}
/// FakeBall is widget to get size of ball
/// the size will updated if the size off ball change
/// {@endtemplate}
class FakeBall extends StatelessWidget {
  /// {@macro fake_ball}
  const FakeBall({
    super.key,
    required this.ball,
    required this.currentBallSize,
    required this.onChanged,
  });

  final Widget ball;
  final Size? currentBallSize;
  final ValueChanged<Size> onChanged;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.0,
      child: MeasureSize(
        onChanged: (size) {
          if (size == currentBallSize) return;

          onChanged(size);
        },
        child: ball,
      ),
    );
  }
}
