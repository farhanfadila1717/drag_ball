import 'package:flutter/material.dart';
import 'package:drag_ball/drag_ball.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ExampleDragball(),
    );
  }
}

class ExampleDragball extends StatelessWidget {
  const ExampleDragball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dragball(
      ball: const FlutterLogo(
        size: 70,
      ),
      ballSize: 70,
      initialPosition: const DragballPosition(
        top: 200,
        isRight: false,
      ),
      onTap: () {
        debugPrint('Dragball Tapped ${DateTime.now().microsecond}');
      },
      onPositionChanged: (DragballPosition position) {
        debugPrint(position.toString());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dragball Example'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
