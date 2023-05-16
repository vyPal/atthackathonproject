import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'loading.dart';
import 'udaje.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 0, 255, 251)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'nazev'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textFieldController_username =
      TextEditingController();
  final TextEditingController textFieldController_password =
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
                controller: textFieldController_password,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = textFieldController_username.text;
                String password = textFieldController_password.text;
                String uid = "70 17 C1 80";

                final response = await dio.post(
                    'http://10.10.11.204:5000/getuserdata',
                    data: FormData.fromMap({
                      "username": username,
                      "password": password,
                      "uuid": uid
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
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
