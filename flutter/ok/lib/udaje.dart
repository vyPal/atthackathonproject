import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Udaje extends StatelessWidget {
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
        body: ListView(children: [
          Column(children: [
            Row(
              children: [
                Column(children: [
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 50.0),
                    child: const Text(
                      'Owner first name: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 20.0),
                    child: const Text(
                      'Owner second name: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 20.0),
                    child: const Text(
                      'Owner phone number: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ])
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 200.0, top: 30.0),
                  child: const Text(
                    'Chip number:                                     ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 200.0, top: 30.0),
                  child: const Text(
                    'Animal type:                                    ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 200.0, top: 30.0),
                  child: const Text(
                    'Birthdate:                                                                                 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: const Text(
                    'Animal name: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Long term illnesses: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Injuries: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Receipts: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Medical reports: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Medication:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: const Text(
                'Alergies: ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ])
        ]));
  }
}
