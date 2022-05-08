import 'package:flutter/material.dart';

enum RotationDirection { clockwise, counterclockwise }

enum StaggeredGridType { square, horizontal, vertical }

extension Direction on RotationDirection {
  bool get isClockwise => this == RotationDirection.clockwise;
}

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

Widget horizontalSpace(double width) {
  return SizedBox(width: width);
}

extension DurationExtension on int {
  Duration get s => Duration(seconds: this);
  Duration get ms => Duration(milliseconds: this);
}

extension WidgetExtension on Widget {
  Widget get ca => Container(
        color: Colors.red,
        child: this,
      );
}
