import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'recepty.dart';

class Udaje extends StatelessWidget {
  Udaje({super.key, this.res});
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
        body: ListView(children: [
          Column(children: [
            Row(
              children: [
                Column(children: [
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 50.0),
                    child: Text(
                      "Owner first name: ${res["ownerFirstname"]}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 20.0),
                    child: Text(
                      'Owner second name: ${res["ownerSecondname"]}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 50.0, top: 20.0),
                    child: Text(
                      'Owner phone number: ${res["ownerNumber"]}',
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
                  child: Text(
                    'Chip number:   ${res["uuid"]}                    ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 200.0, top: 30.0),
                  child: Text(
                    'Animal type:     ${res["AnimalType"]}                ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 200.0, top: 30.0),
                  child: Text(
                    'Birthdate:         ${res["birthdate"]}                                                     ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Animal name: ${res["animalName"]}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: Text(
                'Long term illnesses: ${res["longTermIllnesses"]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: Text(
                'Injuries: ${res["injuries"]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: 1200, top: 30.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Udaje(
                                res: response.data,
                              )),
                    );
                  },
                  child: Text('Recieps'),
                )),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: Text(
                'Medical reports: ${res["medicalReports"]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: Text(
                'Alergies: ${res["alergies"]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ])
        ]));
  }
}
