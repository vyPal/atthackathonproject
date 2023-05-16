import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Medical extends StatelessWidget {
  Medical({super.key, this.res});
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
                'Medical reports: ${res["medicalReports"]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
