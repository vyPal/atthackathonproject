import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'udaje.dart';
import 'package:session_storage/session_storage.dart';

class Newmedic extends StatelessWidget {
  Newmedic({super.key, this.res});
  final TextEditingController textFieldController_pole1 =
      TextEditingController();
  final TextEditingController textFieldController_pole2 =
      TextEditingController();
  final TextEditingController textFieldController_pole3 =
      TextEditingController();
  final session = SessionStorage();

  final res;
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          "Pet tag private info",
          style: TextStyle(
              fontSize: 70,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(children: [
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            controller: textFieldController_pole1,
            decoration: InputDecoration(
              hintText: 'Envim',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            controller: textFieldController_pole3,
            decoration: InputDecoration(
              hintText: 'Datum',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        Container(
          width: 200,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            textAlign: TextAlign.center,
            controller: textFieldController_pole2,
            decoration: InputDecoration(
              hintText: 'Username',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            String obsah = textFieldController_pole1.text;
            String username = textFieldController_pole2.text;
            String date = textFieldController_pole3.text;
            String uid = "70 17 C1 80";

            await dio.post('http://10.10.11.204:5000/newmedicalreport',
                data: FormData.fromMap({
                  "obsah": obsah,
                  "uuid": session["uuid"],
                  "username": username,
                  "date": date,
                }),
                options: Options(headers: {
                  "Access-Control-Allow-Origin": "*",
                  "Access-Control-Allow-Methods": "POST",
                  "Origin": "http://10.10.11.204:5000"
                }));

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Udaje()),
            );
          },
          child: Text('Done'),
        ),
      ]),
    );
  }
}
