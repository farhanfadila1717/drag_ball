<p align="center"><img src="https://github.com/farhanfadila1717/drag_ball/blob/master/display/drag_ball_cover.gif?raw=true" height="200"/></p>

<h1 align="center">Dragball</h1>

<p align="center">A flutter package, inpiration Indonesian e-commerce widget or similiar AssistiveTouch on Iphone.</p><br>

<p align="center">
  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter"
      alt="Platform" />
  </a>
  <a href="https://www.paypal.me/farhanfadila1717">
    <img src="https://img.shields.io/badge/Donate-PayPal-00457C?logo=paypal"
      alt="Donate" />
  </a>
</p><br>

## ⚠️ Warning
* Give the ball the same width as the ball size, for animation calculations
* if you are making ui for web, desktop, please don't use mediaquery computation. Use immutable value if display is resized

----

## Example
```dart
Dragball(
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
```
<br>
<p><img src="https://github.com/farhanfadila1717/drag_ball/blob/master/display/dragball_example.gif?raw=true" height="600"/></p>

----

### 🚧 Maintener 
<a href="https://github.com/farhanfadila1717"><img src="https://avatars.githubusercontent.com/u/43161050?s=100" width="80px;" alt="Farhan Fadila"/></a>
***Farhan Fadila***
📫 How to reach me: farhan.fadila1717@gmail.com


