## [![cover][]][pubdev dragball]

[![flutter][]][web flutter] [![badge paypal][]][paypal account] <br>
A flutter package, inspiration Indonesian e-commerce widget or similiar AssistiveTouch on Iphone.

---

## ⚠️ Note
* Give the ball the same width as the ball size, for animation calculations.
* Put [DragBall] on top the Scaffold


----

## Example
```dart
Dragball(
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
```
### Output

[![output][]][output]

----

### 🚧 Maintener 
[![account avatar][]][github account] <br>
**Farhan Fadila** <br>
📫 How to reach me: farhan.fadila1717@gmail.com

### ❤️ Suport Maintener
[![badge paypal][]][paypal account] [![badge linktree][]][linktree account]

[cover]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/drag_ball/drag_ball.png
[pubdev dragball]: https://pub.dev/packages/drag_ball
[output]: https://github.com/farhanfadila1717/flutter_package/blob/master/display/drag_ball/output.gif
[account avatar]: https://avatars.githubusercontent.com/u/43161050?s=80
[github account]: https://github.com/farhanfadila1717
[badge linktree]: https://img.shields.io/badge/Linktree-farhanfadila-orange
[linktree account]: https://linktr.ee/farhanfadila
[badge paypal]: https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal
[paypal account]: https://www.paypal.me/farhanfadila1717
[flutter]: https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter
[web flutter]: https://flutter.dev

