import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/models/user.dart';
import 'package:flutter_give_collect_money/screens/payment_screen.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';
import 'package:lottie/lottie.dart';

class AppTile extends StatefulWidget {
  final String label;
  final String message;
  final String lottieAssetPath;
  const AppTile(
      {Key? key,
      required this.label,
      required this.message,
      required this.lottieAssetPath})
      : super(key: key);

  @override
  _AppTileState createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  bool onDragTarget = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DragTarget(
        onAccept: (User data) {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 800),
              reverseTransitionDuration: const Duration(milliseconds: 800),
              opaque: false,
              pageBuilder: (context, animation, _) {
                return PaymentScreen(
                  userMakingPayment: data,
                  animation: animation,
                  message: widget.message,
                  heroWidgetKey: widget.label,
                );
              },
            ),
          );
          setState(() {
            onDragTarget = false;
          });
        },
        onMove: (data) {
          setState(() {
            onDragTarget = true;
          });
        },
        onLeave: (_) {
          setState(() {
            onDragTarget = false;
          });
        },
        builder: (_, __, ___) => Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Hero(
                  tag: widget.label,
                  child: Container(
                    height: size.height / 7.2,
                    width: size.width / 2.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              onDragTarget ? Colors.black : Colors.transparent,
                          width: 1.6,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 2,
                          )
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset(
                        widget.lottieAssetPath,
                        height: 60,
                      ),
                      verticalSpace(12),
                      Text(
                        widget.label,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
