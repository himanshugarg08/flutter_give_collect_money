import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/widgets/user_avatar.dart';
import 'package:flutter_give_collect_money/widgets/dotted_circle.dart';
import 'package:flutter_give_collect_money/models/user.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';

class RotatingDottedCircle extends StatefulWidget {
  final double height;
  final RotationDirection rotationDirection;
  final List<User> users;

  const RotatingDottedCircle(
      {Key? key,
      required this.height,
      this.rotationDirection = RotationDirection.clockwise,
      required this.users})
      : super(key: key);

  @override
  State<RotatingDottedCircle> createState() => _RotatingDottedCircleState();
}

class _RotatingDottedCircleState extends State<RotatingDottedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController roatationController;
  late Animation rotationAnimation;

  @override
  void initState() {
    roatationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(roatationController);
    roatationController.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    roatationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationAnimation,
      builder: (_, child) {
        final angle = widget.rotationDirection.isClockwise
            ? rotationAnimation.value
            : -rotationAnimation.value;
        return Transform.rotate(
          angle: angle,
          child: Stack(
            alignment: Alignment.center,
            children: [
              child!,
              ...getUserAvatarWidgetList(angle),
            ],
          ),
        );
      },
      child: IgnorePointer(
        child: DottedCircle(
          height: widget.height,
        ),
      ),
    );
  }

  List<Widget> getUserAvatarWidgetList(double avatarRotationAngle) {
    List<Offset> offsetList = [];
    final circleRadius = widget.height / 2;
    final angle = 2 * pi / widget.users.length;
    for (int userIndex = 0; userIndex < widget.users.length; userIndex++) {
      offsetList.add(Offset(circleRadius * sin(userIndex * angle),
          circleRadius * cos(userIndex * angle)));
    }

    return List.generate(widget.users.length, (index) {
      final currentUser = widget.users[index];
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2 + 25,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Transform.translate(
            offset: offsetList[index],
            child: Transform.rotate(
              angle: -avatarRotationAngle,
              child: DraggableUserWidget(
                currentUser: currentUser,
                circleRadius: circleRadius,
                circleRotationAngle: avatarRotationAngle,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class DraggableUserWidget extends StatefulWidget {
  final User currentUser;
  final double circleRadius;
  final double circleRotationAngle;

  const DraggableUserWidget({
    Key? key,
    required this.currentUser,
    required this.circleRadius,
    required this.circleRotationAngle,
  }) : super(key: key);

  @override
  _DraggableUserWidgetState createState() => _DraggableUserWidgetState();
}

class _DraggableUserWidgetState extends State<DraggableUserWidget>
    with SingleTickerProviderStateMixin {
  late Offset _offset;

  late AnimationController draggablePositionController;
  late Animation draggableAnimation;

  @override
  void initState() {
    _offset = Offset.zero;
    draggablePositionController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    draggablePositionController.addListener(() {
      setState(() {
        _offset = draggableAnimation.value;
        // print("listen $_offset");
      });
    });
    super.initState();
  }

  void takeUserWidgetBackToItsPosition() {
    Offset beginFrom = _offset;

    draggableAnimation = Tween(begin: beginFrom, end: Offset.zero).animate(
      CurvedAnimation(
          parent: draggablePositionController, curve: Curves.easeOutCirc),
    );
    draggablePositionController.reset();
    draggablePositionController.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _offset,
      child: Draggable<User>(
        data: widget.currentUser,
        child: UserAvatar(user: widget.currentUser),
        onDragStarted: () {
          //
        },
        onDragUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        onDragEnd: (_) {
          takeUserWidgetBackToItsPosition();
        },
        onDraggableCanceled: (velocity, offset) {
          //takeUserWidgetBackToItsPosition();
        },
        feedback: UserAvatar(user: widget.currentUser).scale(1.1),
        childWhenDragging: const SizedBox(),
      ),
    );
  }
}

extension GD on Widget {
  Widget scale(double scale) => Transform.scale(
        scale: scale,
        child: this,
      );
}
