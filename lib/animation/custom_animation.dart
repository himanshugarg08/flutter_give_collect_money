import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';

class CustomAnimation extends StatefulWidget {
  final Duration delay;
  final Widget child;
  const CustomAnimation({
    Key? key,
    this.delay = Duration.zero,
    required this.child,
  }) : super(key: key);

  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: 600.ms);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    startAnimation();
  }

  void startAnimation() async {
    await Future.delayed(widget.delay);
    if (mounted) {
      animationController.reset();
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: Offset(0, (10.0 * (1 - animation.value))),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
