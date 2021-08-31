import 'package:flutter/material.dart';
import 'package:drag_ball/drag_ball.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleDragball(),
    );
  }
}

class ExampleDragball extends StatelessWidget {
  const ExampleDragball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dragball(
      ball: FlutterLogo(
        size: 70,
      ),
      initialPosition: const DragballPosition(
        top: 200,
        isRight: false,
      ),
      withIcon: false,
      animationSizeDuration: const Duration(milliseconds: 300),
      ballSize: 70,
      onTap: () {
        debugPrint('Dragball Tapped ${DateTime.now().microsecond}');
      },
      onPositionChanged: (DragballPosition position) {
        debugPrint(position.toString());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dragball Example'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
