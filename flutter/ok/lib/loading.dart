import 'package:flutter/material.dart';
import 'udaje.dart';

class Nacitani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: const Text(
          "Waiting for data",
          style: TextStyle(
            fontSize: 50,
            decoration: TextDecoration.underline, // Nastavení podtržení
            decorationColor:
                Color.fromARGB(255, 118, 118, 118), // Barva podtržení
            decorationThickness: 2.0, // Tloušťka podtržení
            decorationStyle: TextDecorationStyle.double, // Styl podtržení
            color: const Color.fromARGB(255, 0, 0, 0), // Barva textu),
          ),
        ));
  }
}
