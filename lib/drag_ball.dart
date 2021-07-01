import 'package:flutter/material.dart';
import 'dart:math' as math;

class Dragball extends StatefulWidget {
  const Dragball({
    Key? key,
    required this.child,
    required this.ball,
    required this.ballSize,
    required this.onTap,
    this.marginTopBottom = 150,
    this.withIcon = true,
    this.icon,
    this.iconColor,
    this.backgroundIconColor,
    this.borderRadiusBackgroundIcon,
    this.startFromRight = false,
    this.animationSizeDuration,
    this.curveSizeAnimation,
    this.initialTop,
  }) : super(key: key);

  /// Put your screen here
  /// example your [Scaffold]
  final Widget child;

  /// This widget for Custom your ball
  /// example with image
  /// make sure the size is the same as [ballSize] property
  final Widget ball;

  /// Size your ball
  /// Please fill in correctly and the same size as [ball] property, this will affect the calculation process
  final double ballSize;

  /// This function will be called when the ball is pressed
  final Function onTap;

  /// Custom Margin top bottom
  /// Ball would not be in that position
  /// default [marginTopBottom: 150]
  final double marginTopBottom;

  /// Initialization position on the right when first called
  /// default [startFromRight: false]
  final bool startFromRight;

  /// Custom icon hide/show ball
  /// default: [Icons.navigate_before_rounded]
  final IconData? icon;

  /// Background Color for icon
  /// default: [Colors.white]
  final Color? iconColor;

  /// Background Color for Container wrapped Icon
  /// default: [primaryColor]
  final Color? backgroundIconColor;

  /// BorderRadius for Container wrapped Icon
  /// default: [0]
  final BorderRadius? borderRadiusBackgroundIcon;

  /// Custom duration for size animation
  /// default [duration: Duration(milliseconds: 200)]
  final Duration? animationSizeDuration;

  /// CurvesSizeAnimation
  /// default [curve: Curves.easeIn]
  final Curve? curveSizeAnimation;

  /// Initialize position when first called
  /// default [initialTop: 0]
  final double? initialTop;

  /// If you don't want to show ball with icon,
  /// Change value to false
  /// default[withIcon: true]
  final bool withIcon;

  @override
  _DragballState createState() => _DragballState();
}

class _DragballState extends State<Dragball> with TickerProviderStateMixin {
  bool _isBallDraged = false, _isBallHide = false, _isPositionOnRight = false;
  double? _top, _left = 0, _right, _bottom;
  double _angleIcon = 0;
  late IconData _icon;
  late BoxShape _boxShape;
  late BorderRadius? _borderRadiusBackgroundIcon;

  late AnimationController _animationController;
  late AnimationController _offsetAnimationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.animationSizeDuration ?? Duration(milliseconds: 200));
    _sizeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.curveSizeAnimation ?? Curves.easeIn,
    ));
    _offsetAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _offsetAnimation = Tween<double>(begin: 0, end: widget.ballSize / 1.5)
        .animate(CurvedAnimation(
      parent: _offsetAnimationController,
      curve: widget.curveSizeAnimation ?? Curves.easeIn,
    ));
    _icon = widget.icon ?? Icons.navigate_before_rounded;
    _borderRadiusBackgroundIcon = widget.borderRadiusBackgroundIcon;
    _boxShape = widget.borderRadiusBackgroundIcon == null
        ? BoxShape.circle
        : BoxShape.rectangle;

    _initialPosition();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Dragball oldWidget) {
    if (oldWidget.ballSize != widget.ballSize) {
      if (_offsetAnimationController.isCompleted) {
        _offsetAnimationController.reset();
        _offsetAnimation = Tween<double>(begin: 0, end: widget.ballSize / 1.5)
            .animate(CurvedAnimation(
          parent: _offsetAnimationController,
          curve: widget.curveSizeAnimation ?? Curves.easeIn,
        ));
        _isBallHide = false;
        if (_isPositionOnRight) {
          _angleIcon = math.pi;
        } else {
          _angleIcon = 0;
        }
      }
    }
    if (widget.borderRadiusBackgroundIcon != null) {
      if (oldWidget.borderRadiusBackgroundIcon !=
          widget.borderRadiusBackgroundIcon) {
        _borderRadiusBackgroundIcon = widget.borderRadiusBackgroundIcon;
        _boxShape = BoxShape.rectangle;
      }
    } else {
      _borderRadiusBackgroundIcon = null;
      _boxShape = BoxShape.circle;
    }
    super.didUpdateWidget(oldWidget);
  }

  /// function to initialize position
  /// just called on [initState]
  void _initialPosition() {
    _top = widget.initialTop ?? widget.marginTopBottom;
    if (widget.startFromRight) {
      _left = null;
      _right = 0;
      _isPositionOnRight = true;
      _angleIcon = math.pi;
    }
  }

  /// Monitor if there is scroll activity
  /// if there is scroll activity this function will trigger size animation
  bool _onNotification(ScrollNotification? scrollNotification) {
    if (scrollNotification == null) {
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

  /// This function will be called the first time
  /// when the user drag the ball
  void _onDragStarted() {
    setState(() {
      _isBallDraged = true;
    });
  }

  /// This function will hide the ball or show the ball
  void _onHideOrShowBall() {
    if (!_isBallHide) {
      _offsetAnimationController.forward();
      if (_isPositionOnRight) {
        _angleIcon = 0;
      } else {
        _angleIcon = math.pi;
      }
    } else {
      _offsetAnimationController.reverse();
      if (_isPositionOnRight) {
        _angleIcon = math.pi;
      } else {
        _angleIcon = 0;
      }
    }
    setState(() {
      _isBallHide = !_isBallHide;
    });
  }

  /// When the user releases the ball, this function will
  /// calculate the position of the ball
  void _onDragEnd(DraggableDetails details, Size size) {
    final Offset offset = details.offset;
    final double halfWidthBall = widget.ballSize / 1.5;
    final double halfWidth = size.width / 2 - halfWidthBall;
    final double maxHeight = size.height - 150.0;

    if (offset.dy < widget.marginTopBottom) {
      _top = widget.marginTopBottom;
      _bottom = null;
    } else if (offset.dy > widget.marginTopBottom && offset.dy < maxHeight) {
      _top = offset.dy;
      _bottom = null;
    } else {
      _bottom = widget.marginTopBottom;
      _top = null;
    }
    if (offset.dx > halfWidth) {
      _right = 0;
      _angleIcon = _isBallHide ? 0 : math.pi;
      _isPositionOnRight = true;
      _left = null;
    } else {
      _right = null;
      _isPositionOnRight = false;
      _angleIcon = !_isBallHide ? 0 : math.pi;
      _left = 0;
    }
    _isBallDraged = false;
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    _offsetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: _onNotification,
      child: Stack(
        children: [
          RepaintBoundary(
            child: widget.child,
          ),
          Positioned(
            top: _top,
            left: _left,
            right: _right,
            bottom: _bottom,
            width: widget.ballSize + 15,
            height: widget.ballSize,
            child: AnimatedBuilder(
              animation: _offsetAnimationController,
              builder: (context, child) {
                if (_isPositionOnRight) {
                  return Transform.translate(
                    offset: Offset(_offsetAnimation.value, 0),
                    child: child,
                  );
                } else {
                  return Transform.translate(
                    offset: Offset(-_offsetAnimation.value, 0),
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
                  child: _isBallDraged
                      ? SizedBox.shrink()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              right: _isPositionOnRight ? 0 : null,
                              left: !_isPositionOnRight ? 0 : null,
                              child: MouseRegion(
                                cursor: MaterialStateMouseCursor.clickable,
                                child: GestureDetector(
                                  child: widget.ball,
                                  onTap: !_isBallHide
                                      ? () {
                                          widget.onTap();
                                        }
                                      : null,
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) => widget.withIcon
                                  ? Positioned(
                                      right: _isPositionOnRight ? null : 0,
                                      left: !_isPositionOnRight ? null : 0,
                                      child: GestureDetector(
                                        onTap: () => _onHideOrShowBall(),
                                        behavior: HitTestBehavior.translucent,
                                        child: Transform.rotate(
                                          angle: _angleIcon,
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color:
                                                  widget.backgroundIconColor ??
                                                      theme.primaryColor,
                                              borderRadius:
                                                  _borderRadiusBackgroundIcon,
                                              shape: _boxShape,
                                            ),
                                            child: SizedBox.expand(
                                              child: Icon(
                                                _icon,
                                                color: widget.iconColor ??
                                                    Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                  feedback: widget.ball,
                  onDragStarted: () => _onDragStarted(),
                  onDragEnd: (details) => _onDragEnd(details, size),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
