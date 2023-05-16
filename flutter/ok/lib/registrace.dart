import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'udaje.dart';

class Registrace extends StatelessWidget {
  final TextEditingController textFieldController_username =
      TextEditingController();
  final TextEditingController textFieldController_password1 =
      TextEditingController();
  final TextEditingController textFieldController_password2 =
      TextEditingController();
  final TextEditingController textFieldController_firstname =
      TextEditingController();
  final TextEditingController textFieldController_secondname =
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
                controller: textFieldController_username,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
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
                controller: textFieldController_password1,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
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
                controller: textFieldController_password2,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
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
                controller: textFieldController_firstname,
                decoration: InputDecoration(
                  hintText: 'First name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
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
                controller: textFieldController_secondname,
                decoration: InputDecoration(
                  hintText: 'Second name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = textFieldController_username.text;
                String password1 = textFieldController_password1.text;
                String password2 = textFieldController_password2.text;
                String firstname = textFieldController_firstname.text;
                String secondname = textFieldController_secondname.text;
                String uid = "70 17 C1 80";

                final response =
                    await dio.post('http://10.10.11.204:5000/getdoctordata',
                        data: FormData.fromMap({
                          "username": username,
                          "password1": password1,
                          "password2": password2,
                          "firstname": firstname,
                          "secondname": secondname
                        }),
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
