import 'package:drag_ball/drag_ball.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dragball test', () {
    testWidgets('Show / Hide from Controller test', (tester) async {
      final controller = DragballController();

      final widget = WrapAppTest(
        child: Dragball(
          controller: controller,
          ball: FlutterLogo(size: 55),
          onTap: () {},
          initialPosition: DragballPosition.defaultPosition(),
          onPositionChanged: (position) => debugPrint(
            position.toString(),
          ),
          child: SizedBox.fromSize(
            size: Size(300, 600),
          ),
        ),
      );

      final ball = find.byType(FlutterLogo);
      await tester.pumpWidget(widget);
      expect(ball, findsOneWidget);

      controller.hide();
      await tester.pumpAndSettle();
      expect(controller.value, BallState.hide);
    });
  });
}

class WrapAppTest extends StatelessWidget {
  const WrapAppTest({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: child,
      );
}
