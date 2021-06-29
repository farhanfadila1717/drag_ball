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
      home: ExampleDragBall(),
    );
  }
}

class ExampleDragBall extends StatefulWidget {
  const ExampleDragBall({Key? key}) : super(key: key);

  @override
  _ExampleDragBallState createState() => _ExampleDragBallState();
}

class _ExampleDragBallState extends State<ExampleDragBall> {
  @override
  Widget build(BuildContext context) {
    return Dragball(
      ball: FlutterLogo(
        size: 70,
      ),
      ballSize: 70,
      startFromRight: true,
      onTap: () {
        debugPrint('Dragball Tapped ${DateTime.now().microsecond}');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dragball Example'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return Container(
              height: 250,
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
