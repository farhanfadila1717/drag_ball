import 'dart:math' as math show pi;
import 'package:drag_ball/drag_ball.dart';
import 'package:drag_ball/src/models/ball_limit_area.dart';
import 'package:drag_ball/src/widgets/fake_ball.dart';
import 'package:flutter/material.dart';

const Duration _kDefaultAnimationDuration = Duration(
  milliseconds: 300,
);

const BallLimitArea _kDefaultBallLimitArea = BallLimitArea(
  top: 100.0,
  bottom: 100.0,
  useSafeArea: true,
);

/// {@template drag_ball}
/// Dragball is the widget similiar AssistiveTouch on Iphone.
///
/// Example:
/// ```dart
///   Dragball(
///     child: YourScreenPage
///   )
/// ```
/// {@endtemplate}
class Dragball extends StatefulWidget {
  /// {@macro drag_ball}
  const Dragball({
    super.key,
    required this.child,
    required this.ball,
    required this.initialPosition,
    this.onPositionChanged,
    this.onTap,
    this.controller,
    this.ballLimitArea = _kDefaultBallLimitArea,
    this.withIcon = true,
    this.icon,
    this.iconSize = 24,
    this.rotateIcon = true,
    this.animationSizeDuration,
    this.curveSizeAnimation,
    this.iconPosition = IconPosition.center,
    this.scrollAndHide = true,
  });

  /// Put your screen here
  /// example:
  /// ```dart
  /// Dragaball(
  ///   // your entire screen page
  ///   child: Scaffold
  /// )
  /// ```
  final Widget child;

  /// This widget for Custom your ball
  /// example with image
  /// make sure the size is the same as [ballSize] property
  final Widget ball;

  /// {@macro DragballController}
  final DragballController? controller;

  /// This function will be called when the ball is pressed
  final VoidCallback? onTap;

  /// [initialPosition] will be the location or display
  /// or configuration of the first position [Dragball]
  final DragballPosition initialPosition;

  /// The limit area within which a ball widget can be moved.
  final BallLimitArea ballLimitArea;

  /// If you don't want to show ball with icon,
  /// Change value to false
  /// default[withIcon: true]
  final bool withIcon;

  /// Custom icon for controll hide/show ball
  final Widget? icon;

  /// If you want custom icon size
  /// Change value with you want
  /// default icon size 24
  final double iconSize;

  /// if you don't want any icon rotation animation on [ball] in hide or show,
  /// change this property to false
  /// default true
  final bool rotateIcon;

  /// Custom duration for size animation
  /// default [duration: Duration(milliseconds: 200)]
  final Duration? animationSizeDuration;

  /// CurvesSizeAnimation
  /// default [curve: Curves.easeIn]
  final Curve? curveSizeAnimation;

  /// this function will return the value of [DragballPosition]
  /// every time the position changes
  final ValueChanged<DragballPosition>? onPositionChanged;

  /// Use this property to set [IconPosition] the top, center, or bottom position of the icon.
  /// Default [IconPostion] is center
  final IconPosition iconPosition;

  /// if you don't want size animation when user scrolls, set this property value to false
  /// Default true
  final bool scrollAndHide;

  @override
  _DragballState createState() => _DragballState();
}

class _DragballState extends State<Dragball> with TickerProviderStateMixin {
  bool _isBallDraged = false, _isPositionOnRight = false;
  double? _top, _left = 0, _right, _bottom;
  Size? _ballSize;
  late BallState _ballState;
  late DragballPosition _dragballPosition;
  late final DragballController _controller;
  late final AnimationController _animationController;
  late final AnimationController _offsetAnimationController;
  late final AnimationController _rotateIconAnimationController;
  late final Animation<double> _sizeAnimation;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _rotateIconAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initialPosition();
    _initController();
  }

  @override
  void didUpdateWidget(covariant Dragball oldWidget) {
    if (widget.animationSizeDuration != oldWidget.animationSizeDuration) {
      _animationController.duration = widget.animationSizeDuration;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _initialPosition() {
    final position = widget.initialPosition;
    final isRight = position.isRight;

    _dragballPosition = widget.initialPosition;
    _top = widget.initialPosition.top;
    _ballState = position.ballState;
    if (isRight) {
      _left = null;
      _right = 0;
      _isPositionOnRight = true;

      if (!_ballState.isHide) {
        _rotateIconAnimationController.value = 1.0;
      } else {
        _offsetAnimationController.value = 1.0;
      }
    } else {
      _left = 0;
      _right = null;
      _isPositionOnRight = false;

      if (!_ballState.isHide) {
        _offsetAnimationController.value = 1.0;
        _rotateIconAnimationController.value = 1.0;
      }
    }
  }

  void _initAnimation() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.animationSizeDuration ?? _kDefaultAnimationDuration);
    _sizeAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curveSizeAnimation ?? Curves.easeIn,
      ),
    );
    _offsetAnimationController =
        AnimationController(vsync: this, duration: _kDefaultAnimationDuration);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.6, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _offsetAnimationController,
        curve: Curves.easeIn,
      ),
    );
    _rotateIconAnimationController =
        AnimationController(vsync: this, duration: _kDefaultAnimationDuration);
    _rotateIconAnimation = Tween<double>(begin: 0, end: -math.pi)
        .animate(_rotateIconAnimationController);
  }

  void _initController() {
    _controller = widget.controller ?? DragballController();

    _controller.addListener(() {
      _ballState = _controller.value;
      _onHideOrShowBall();
    });
  }

  bool _onNotification(ScrollNotification? scrollNotification) {
    if (scrollNotification == null || !widget.scrollAndHide) {
      return false;
    }
    if (scrollNotification is ScrollStartNotification) {
      if (scrollNotification.metrics.axis == Axis.vertical) {
        _animationController.forward();
      }
    }
    if (scrollNotification is ScrollEndNotification) {
      if (scrollNotification.metrics.axis == Axis.vertical) {
        _animationController.reverse();
      }
    }
    return false;
  }

  void _onDragStarted() => setState(() {
        _isBallDraged = true;
      });

  void _onHideOrShowBall() {
    if (_ballState.isHide) {
      _offsetAnimationController.forward();
      if (_isPositionOnRight) {
        _rotateIconAnimationController.reverse();
      } else {
        _rotateIconAnimationController.forward();
      }
    } else {
      _offsetAnimationController.reverse();
      if (_isPositionOnRight) {
        _rotateIconAnimationController.forward();
      } else {
        _rotateIconAnimationController.reverse();
      }
    }

    widget.onPositionChanged?.call(
      _dragballPosition.copyWith(ballState: _ballState),
    );
  }

  /// Callback method invoked when the user completes dragging the ball widget.
  ///
  /// The method updates the position of the ball based on the drag details and the size
  /// of the parent widget. It also triggers an animation of a rotation icon depending on
  /// the ball's position. Finally, it calls the `onPositionChanged` callback function
  /// provided by the parent widget to notify it of the updated position of the ball.
  void _onDragEnd(DraggableDetails details, Size size, EdgeInsets viewPadding) {
    final Offset offset = details.offset;
    final double halfWidthBall = _ballSize!.width / 1.5;
    final double halfWidth = size.width / 2 - halfWidthBall;
    final double ballLimitAreaTop =
        widget.ballLimitArea.topWithSafeArea(viewPadding.top);
    final double ballLimitAreaBottom =
        widget.ballLimitArea.bottomWithSafeArea(viewPadding.bottom);

    final y = offset.dy;

    if (y < ballLimitAreaTop) {
      _top = ballLimitAreaTop;
      _bottom = null;
    } else if (y >= size.height - ballLimitAreaBottom) {
      _top = null;
      _bottom = ballLimitAreaBottom;
    } else {
      _top = y;
      _bottom = null;
    }

    // If the ball's end drag position is to the right of the horizontal center of
    // the widget, position the ball on the right edge of the widget by setting the
    // right position to 0 and clearing the left position. Also update the `_isPositionOnRight`
    // and `_ballState` properties of the widget and trigger the appropriate animation
    // based on whether the ball is currently hidden or not. Otherwise, position the
    // ball on the left edge of the widget by setting the left position to 0 and clearing
    // the right position. Also update the `_isPositionOnRight` property and trigger
    // the appropriate animation to rotate the icon.
    if (offset.dx > halfWidth) {
      _right = 0;
      _isPositionOnRight = true;
      _left = null;
      _ballState.isHide
          ? _rotateIconAnimationController.reverse()
          : _rotateIconAnimationController.forward();
    } else {
      _right = null;
      _isPositionOnRight = false;

      _left = 0;
      !_ballState.isHide
          ? _rotateIconAnimationController.reverse()
          : _rotateIconAnimationController.forward();
    }
    _isBallDraged = false;

    widget.onPositionChanged?.call(
      _dragballPosition.copyWith(isRight: _isPositionOnRight, top: _top),
    );
    setState(() {});
  }

  /// When ball position change from left to right or right to left
  /// this method will determine the position of the icon.
  Alignment get _iconAlignment {
    if (_isPositionOnRight) {
      switch (widget.iconPosition) {
        case IconPosition.top:
          return Alignment.topLeft;
        case IconPosition.center:
          return Alignment.centerLeft;
        default:
          return Alignment.bottomLeft;
      }
    } else {
      switch (widget.iconPosition) {
        case IconPosition.top:
          return Alignment.topRight;
        case IconPosition.center:
          return Alignment.centerRight;
        default:
          return Alignment.bottomRight;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _offsetAnimationController.dispose();
    _rotateIconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;
    final EdgeInsets viewPadding = mediaQueryData.viewPadding;
    final ThemeData theme = Theme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: Stack(
        children: [
          FakeBall(
            ball: widget.ball,
            currentBallSize: _ballSize,
            onChanged: (size) {
              setState(() {
                _ballSize = size;
              });
            },
          ),
          RepaintBoundary(
            child: widget.child,
          ),
          if (_ballSize != null)
            Positioned(
              top: _top,
              left: _left,
              right: _right,
              bottom: _bottom,
              width: _ballSize!.width +
                  (widget.iconSize + (widget.icon == null ? 3 : 0)) / 2,
              height: _ballSize!.width,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOutSine,
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: _isPositionOnRight
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                ),
                child: _ballState.isHide
                    ? SizedBox.fromSize(
                        size: _ballSize ?? Size.zero,
                      )
                    : AnimatedBuilder(
                        animation: _offsetAnimationController,
                        builder: (context, child) {
                          if (_isPositionOnRight) {
                            return FractionalTranslation(
                              translation: _offsetAnimation.value,
                              child: child,
                            );
                          } else {
                            return FractionalTranslation(
                              translation:
                                  Offset(-_offsetAnimation.value.dx, 0.0),
                              child: child,
                            );
                          }
                        },
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _sizeAnimation.value,
                              child: child,
                            );
                          },
                          child: Draggable(
                            child: Visibility(
                              visible: !_isBallDraged,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    right: _isPositionOnRight ? 0 : null,
                                    left: !_isPositionOnRight ? 0 : null,
                                    child: MouseRegion(
                                      cursor:
                                          MaterialStateMouseCursor.clickable,
                                      child: GestureDetector(
                                        child: widget.ball,
                                        onTap: !_ballState.isHide
                                            ? widget.onTap
                                            : null,
                                      ),
                                    ),
                                  ),
                                  if (widget.withIcon)
                                    Align(
                                      alignment: _iconAlignment,
                                      child: GestureDetector(
                                        onTap: _controller.reverse,
                                        behavior: HitTestBehavior.translucent,
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: AnimatedBuilder(
                                            animation:
                                                _rotateIconAnimationController,
                                            builder: (context, icon) {
                                              return Transform.rotate(
                                                angle: widget.rotateIcon
                                                    ? _rotateIconAnimation.value
                                                    : 0.0,
                                                child: icon,
                                              );
                                            },
                                            child: widget.icon ??
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: theme.primaryColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(3),
                                                    child: Icon(
                                                      Icons
                                                          .navigate_before_rounded,
                                                      size: widget.iconSize,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            feedback: widget.ball,
                            onDragStarted: () => _onDragStarted(),
                            onDragEnd: (details) =>
                                _onDragEnd(details, size, viewPadding),
                          ),
                        ),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
