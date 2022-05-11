import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/animation/custom_animation.dart';
import 'package:flutter_give_collect_money/animation/custom_translation_animation.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';
import 'package:flutter_give_collect_money/widgets/amount_container.dart';
import 'package:flutter_give_collect_money/widgets/message_container.dart';
import 'package:lottie/lottie.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class KeyboardPad extends StatefulWidget {
  final VoidCallback? onSend;
  final VoidCallback onPop;
  final String action;
  const KeyboardPad({
    Key? key,
    this.onSend,
    required this.action,
    required this.onPop,
  }) : super(key: key);

  @override
  _KeyboardPadState createState() => _KeyboardPadState();
}

class _KeyboardPadState extends State<KeyboardPad>
    with SingleTickerProviderStateMixin {
  List<String> amount = [r'$'];

  final testStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w800,
  );

  final BoxDecoration decoration = const BoxDecoration(
    color: Colors.white,
  );

  bool isAmountLimitReached() {
    return amount.length >= 11;
  }

  bool isSending = false;
  bool showCursor = true;

  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: 400.ms);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          showCursor = false;
        });
        await Future.delayed(200.ms);
        setState(() {
          isSending = true;
        });
      }
    });
  }

  void addValueToAmount(String value) {
    int amountListLength = amount.length;

    if (amountListLength < 5 || (amount[amountListLength - 3] != '.')) {
      setState(() {
        amount.add(value);
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: isSending
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          CustomAnimation(
              delay: 800.ms,
              child: AmountContainer(
                amount: amount,
                showCursor: showCursor,
              )),
          isSending
              ? TweenAnimationBuilder(
                  duration: 200.ms,
                  curve: Curves.easeInOut,
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, _) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: const Offset(0, -24),
                        child: Lottie.asset(
                          widget.action == "Payment"
                              ? "assets/face_id_scan.json"
                              : "assets/receive_money.json",
                          height: 280,
                          onLoaded: (composition) async {
                            await Future.delayed(composition.duration);
                            widget.onPop();
                            Navigator.of(context).pop();
                          },
                          repeat: false,
                        ),
                      ),
                    );
                  })
              : AnimatedBuilder(
                  animation: animation,
                  builder: (_, child) => Transform.translate(
                    offset: Offset(0, ((size.height / 4) * animation.value)),
                    child: child,
                  ),
                  child: Column(
                    children: [
                      CustomAnimation(
                          delay: 1000.ms, child: const MessageContainer()),
                      verticalSpace(12),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 2,
                            offset: const Offset(0, 20),
                          )
                        ]),
                        child: CustomTranslationAnimation(
                          delay: 1200.ms,
                          begin: const Offset(0, 400),
                          child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            itemCount: 14,
                            crossAxisCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            staggeredTileBuilder: (index) =>
                                const StaggeredTile.fit(1),
                            itemBuilder: (context, index) {
                              return buildTile(index, size);
                            },
                          ),
                        ),
                      ),
                      verticalSpace(16),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Widget buildTile(int index, Size size) {
    final height = size.height / 12;

    if (index == 3) {
      return GestureDetector(
        onTap: () {
          if (amount.first != amount.last) {
            if (amount.length >= 3) {
              if (amount[1] == '0' && amount[2] == '.' && amount.length == 3) {
                amount.removeLast();
              }
            }
            amount.removeLast();
            setState(() {});
          }
        },
        child: Container(
          decoration: decoration,
          height: height,
          child: Center(
              child: Image.asset(
            "assets/clear_symbol_bold.png",
            height: 28,
          )),
        ),
      );
    }

    if (index == 7) {
      return GestureDetector(
        onTap: () {
          if (amount.length != 1) {
            widget.onSend?.call();
            isSending = false;
            animationController.reset();
            animationController.forward();
          }
        },
        child: ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(24)),
          child: Container(
              decoration: decoration.copyWith(color: Colors.black),
              height: height * 3,
              child: Center(
                  child: Text(
                "SEND",
                style: testStyle.copyWith(color: Colors.white),
              ))),
        ),
      );
    }

    if (index == 11 || index == 12) {
      return GestureDetector(
        onTap: () {
          if (amount.first != amount.last && !isAmountLimitReached()) {
            addValueToAmount("0");
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(index == 11 ? 24 : 0),
          ),
          child: Container(
              decoration: decoration,
              height: height,
              child: index == 11
                  ? Center(
                      child: Text(
                        "0",
                        style: testStyle,
                      ),
                    )
                  : const SizedBox()),
        ),
      );
    }

    if (index == 13) {
      return GestureDetector(
        onTap: () {
          if (!amount.contains('.') && !isAmountLimitReached()) {
            if (amount.first != amount.last) {
              addValueToAmount(".");
            } else {
              addValueToAmount("0");
              addValueToAmount(".");
            }
          }
        },
        child: Container(
            decoration: decoration,
            height: height,
            child: Center(
                child: Text(
              ".",
              style: testStyle,
            ))),
      );
    }

    return buildDigitTile(getTileString(index), height);
  }

  Widget buildDigitTile(String value, double height) {
    return GestureDetector(
      onTap: () {
        if (!isAmountLimitReached()) {
          addValueToAmount(value);
        }
      },
      child: Container(
        decoration: decoration,
        height: height,
        child: Center(
          child: Text(
            value,
            style: testStyle,
          ),
        ),
      ),
    );
  }

  String getTileString(int index) {
    if (4 <= index && index < 8) return "$index";
    if (8 <= index && index < 12) return "${index - 1}";
    return "${index + 1}";
  }
}
