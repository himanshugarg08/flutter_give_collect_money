import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/screens/transactions_screen.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 3.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            verticalSpace(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello, Himanshu",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    verticalSpace(4),
                    const Text(
                      "Balance",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/app_logo.png',
                  color: Colors.white,
                  height: 22,
                )
              ],
            ),
            verticalSpace(8),
            Row(
              children: const [
                Text(
                  r'''$9844.00''',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            verticalSpace(16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 800),
                    reverseTransitionDuration:
                        const Duration(milliseconds: 800),
                    opaque: false,
                    pageBuilder: (context, animation, _) {
                      return const TransactionsPage();
                    },
                  ),
                );
              },
              child: Hero(
                tag: "Your transaction",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Material(
                        child: Text(
                          "Your transaction",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
