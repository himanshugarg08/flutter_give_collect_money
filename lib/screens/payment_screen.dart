import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/animation/custom_animation.dart';
import 'package:flutter_give_collect_money/models/user.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';
import 'package:flutter_give_collect_money/widgets/animated_user_avatar.dart';
import 'package:flutter_give_collect_money/widgets/keyboard_pad.dart';

class PaymentScreen extends StatefulWidget {
  final User userMakingPayment;
  final Animation<double> animation;
  final String message;
  final String heroWidgetKey;
  const PaymentScreen({
    Key? key,
    required this.userMakingPayment,
    required this.animation,
    required this.message,
    required this.heroWidgetKey,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  bool showContent = false;

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    Future.delayed(
        600.ms,
        () => setState(() {
              showContent = true;
            }));
    animationController = AnimationController(vsync: this, duration: 700.ms);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    super.initState();
  }

  void onSend() {
    animationController.reset();
    animationController.forward();
  }

  void onPop() {
    setState(() {
      showContent = false;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        onPop();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: showContent
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.black,
                leading: IconButton(
                    onPressed: () {
                      onPop();
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
              )
            : null,
        body: Stack(
          children: [
            FadeTransition(
              opacity: widget.animation,
              child: Container(
                color: Colors.black,
                height: size.height,
                width: size.width,
              ),
            ),
            AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Transform.translate(
                    offset: Offset(0, ((size.height / 5) * animation.value)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Hero(
                            tag: widget.heroWidgetKey,
                            child: AnimatedBuilder(
                                animation: widget.animation,
                                builder: (context, _) {
                                  return Container(
                                    height: size.height * 0.75,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16 +
                                                12 * widget.animation.value))),
                                  );
                                }),
                          ),
                        ),
                        if (showContent)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: size.height * 0.75,
                              width: size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AnimatedUserAvatar(
                                      user: widget.userMakingPayment),
                                  CustomAnimation(
                                    delay: 600.ms,
                                    child: Transform.translate(
                                        offset: const Offset(0, -24),
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: widget.message,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                              children: [
                                                TextSpan(
                                                    text: widget
                                                        .userMakingPayment.name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ]),
                                        )),
                                  ),
                                  Expanded(
                                    child: KeyboardPad(
                                      onSend: onSend,
                                      action: widget.heroWidgetKey,
                                      onPop: onPop,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
