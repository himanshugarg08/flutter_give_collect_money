import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';
import 'package:flutter_give_collect_money/widgets/animated_cursor.dart';

class AmountContainer extends StatelessWidget {
  final List<String> amount;
  final bool showCursor;
  const AmountContainer({
    Key? key,
    required this.amount,
    this.showCursor = true,
  }) : super(key: key);

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size;
  }

  double cursorOffset() {
    return (8 * (amount.length - 1)) / 10;
  }

  double rowOffset() {
    return (40 * (amount.length - 1)) / 10;
  }

  @override
  Widget build(BuildContext context) {
    final duration = 200.ms;
    const fontSize = 40.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 48.0),
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(15, 0),
                child: AnimatedContainer(
                  duration: duration,
                  width: calcTextSize(amount.join(),
                              const TextStyle(fontSize: fontSize))
                          .width +
                      50,
                  child: Row(
                    children: [
                      ...amount.map((e) {
                        return TweenAnimationBuilder(
                          duration: duration,
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (_, double v, c) {
                            return Opacity(
                              opacity: v,
                              child: c,
                            );
                          },
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              if (showCursor)
                AnimatedContainer(
                  duration: duration,
                  width: calcTextSize(amount.join(),
                              const TextStyle(fontSize: fontSize))
                          .width +
                      20 +
                      cursorOffset(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedCursor(
                        height: calcTextSize(amount.join(),
                                const TextStyle(fontSize: fontSize))
                            .height,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
