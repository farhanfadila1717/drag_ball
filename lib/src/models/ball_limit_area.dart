class BallLimitArea {
  final double top;
  final double bottom;
  final bool useSafeArea;

  const BallLimitArea({
    required this.top,
    required this.bottom,
    required this.useSafeArea,
  });

  double topWithSafeArea(double safeAreaValue) =>
      top + (useSafeArea ? safeAreaValue : 0);

  double bottomWithSafeArea(double safeAreaValue) =>
      top + (useSafeArea ? safeAreaValue : 0);
}
