import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ok/newrecipe.dart';
import 'recepty.dart';
import 'medical.dart';
import 'newrecipe.dart';
import 'newmedic.dart';
import 'package:session_storage/session_storage.dart';

class Udaje extends StatelessWidget {
  Udaje({super.key, this.res});
  final res;
  final dio = Dio();
  final session = SessionStorage();

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
              child: ElevatedButton(
                  onPressed: () async {
                    final response =
                        await dio.post('http://10.10.11.204:5000/recipes',
                            data: FormData.fromMap({"uuid": session["uuid"]}),
                            options: Options(headers: {
                              "Access-Control-Allow-Origin": "*",
                              "Access-Control-Allow-Methods": "POST",
                              "Origin": "http://10.10.11.204:5000"
                            }));
                    print(response);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recepty(
                                res: response.data,
                              )),
                    );
                  },
                  child: Text('Reciep')),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: ElevatedButton(
                  onPressed: () async {
                    String uid = "70 17 C1 80";

                    final response = await dio.post(
                        'http://10.10.11.204:5000/medicalreports',
                        data: FormData.fromMap({"uuid": session["uuid"]}),
                        options: Options(headers: {
                          "Access-Control-Allow-Origin": "*",
                          "Access-Control-Allow-Methods": "POST",
                          "Origin": "http://10.10.11.204:5000"
                        }));
                    print(response);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Medical(
                                res: response.data,
                              )),
                    );
                  },
                  child: Text('Medical')),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: ElevatedButton(
                  onPressed: () async {
                    String uid = "70 17 C1 80";

                    final response =
                        await dio.post('http://10.10.11.204:5000/getdoctordata',
                            data: FormData.fromMap({"uuid": session["uuid"]}),
                            options: Options(headers: {
                              "Access-Control-Allow-Origin": "*",
                              "Access-Control-Allow-Methods": "POST",
                              "Origin": "http://10.10.11.204:5000"
                            }));
                    print(response);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Newrecipe(
                                res: response.data,
                              )),
                    );
                  },
                  child: Text('New recipe')),
            ),
            Container(
              padding: EdgeInsets.only(right: 1200, top: 30.0),
              child: ElevatedButton(
                  onPressed: () async {
                    String uid = "70 17 C1 80";

                    final response =
                        await dio.post('http://10.10.11.204:5000/getdoctordata',
                            data: FormData.fromMap({"uuid": session["uuid"]}),
                            options: Options(headers: {
                              "Access-Control-Allow-Origin": "*",
                              "Access-Control-Allow-Methods": "POST",
                              "Origin": "http://10.10.11.204:5000"
                            }));
                    print(response);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Newmedic(
                                res: response.data,
                              )),
                    );
                  },
                  child: Text('New medic')),
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
