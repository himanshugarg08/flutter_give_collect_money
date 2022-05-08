import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "Your transaction",
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Your transaction"),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
        ));
  }
}
