import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Recepty extends StatelessWidget {
  Recepty({super.key, this.res});
  final res;
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          "Název",
          style: TextStyle(
              fontSize: 70,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Recipies: ${res["receipts"]}  ",
                style: TextStyle(fontSize: 30),
              )
            ],
          )
        ],
      ),
    );
  }
}
