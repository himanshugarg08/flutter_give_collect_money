import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/models/user.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';
import 'package:flutter_give_collect_money/widgets/rotating_dotted_circle.dart';

GlobalKey revolvingWidgetKey = GlobalKey();

class RevolvingUserWidget extends StatefulWidget {
  const RevolvingUserWidget({Key? key}) : super(key: key);

  @override
  _RevolvingUserWidgetState createState() => _RevolvingUserWidgetState();
}

class _RevolvingUserWidgetState extends State<RevolvingUserWidget> {
  final double distanceBetweenDottedCircle = 140;
  final double smallestCircleHeight = 80;
  final double delta = 20;

  @override
  Widget build(BuildContext context) {
    final userList = UserList.users;
    return Stack(
      key: revolvingWidgetKey,
      alignment: Alignment.center,
      children: [
        RotatingDottedCircle(
          height: smallestCircleHeight +
              2 * delta +
              2 * distanceBetweenDottedCircle,
          users: userList.sublist(0, 4),
        ),
        RotatingDottedCircle(
          height: smallestCircleHeight + delta + distanceBetweenDottedCircle,
          rotationDirection: RotationDirection.counterclockwise,
          users: userList.sublist(4),
        ),
        RotatingDottedCircle(
          height: smallestCircleHeight,
          users: const [],
        ),
      ],
    );
  }
}
