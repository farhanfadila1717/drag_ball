## [![cover][]][pubdev dragball]

[![flutter][]][web flutter] [![badge paypal][]][paypal account] <br>
A flutter package, inspiration Indonesian e-commerce widget or similiar AssistiveTouch on Iphone.

---

## ⚠️ Note
* Put [DragBall] on top the Scaffold


----

## Example
```dart
Dragball(
  ball: const FlutterLogo(
    size: 70,
  ),
  initialPosition: DragballPosition.defaultPosition(),
  onTap: () => debugPrint('Dragball Tapped'),
  onPositionChanged: (DragballPosition position) =>
      debugPrint(position.toString()),
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

