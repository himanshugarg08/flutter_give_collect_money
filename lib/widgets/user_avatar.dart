import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/models/user.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final double radius;
  const UserAvatar({
    Key? key,
    required this.user,
    this.radius = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        height: 2 * radius,
        child: Image.network(user.image),
      ),
    );

    // return CircleAvatar(
    //   radius: radius,
    //   backgroundImage: NetworkImage(user.image),
    // );
  }
}
