import 'package:flutter/material.dart';
import 'package:flutter_give_collect_money/models/country.dart';
import 'package:flutter_give_collect_money/utils/utils.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({Key? key}) : super(key: key);

  final double height = 50;

  final country = const Country("USD", "assets/usa_flag.png");

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 40,
                  spreadRadius: 2,
                )
              ]),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    country.flagImageUrl,
                    fit: BoxFit.cover,
                    alignment: const Alignment(-0.32, 0),
                  ),
                ),
              ),
              horizontalSpace(8),
              Text(
                country.currency,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 2,
                  )
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: "Say Something",
                hintStyle: TextStyle(color: Colors.grey.shade300),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: height / 4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
