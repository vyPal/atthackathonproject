import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'udaje.dart';
import 'promnene.dart';

class Vojta extends StatelessWidget {
  final TextEditingController textFieldController_pation =
      TextEditingController();

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                controller: textFieldController_pation,
                decoration: InputDecoration(
                  hintText: 'Pation chip',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String uuid = textFieldController_pation.text;
                Newrecipe().prijmiHodnotu(uuid);
                final response =
                    await dio.post('http://10.10.11.204:5000/getdoctordata',
                        data: FormData.fromMap({"uuid": uuid}),
                        options: Options(headers: {
                          "Access-Control-Allow-Origin": "*",
                          "Access-Control-Allow-Methods": "POST",
                          "Origin": "http://10.10.11.204:5000"
                        }));
                print(response);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Udaje(
                            res: response.data,
                          )),
                );
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
