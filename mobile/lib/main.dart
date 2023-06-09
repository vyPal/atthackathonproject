import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pet tag public info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Map<String, dynamic> animal = {};
  List<ScanResult> devices = [];
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    idk();
  }

  Future<List<ScanResult>> bluetoothScan() async {
    List<ScanResult> bluetoothDevices = [];
    FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
    //Stop scan before restarting scan too prevent errors when trying to scan
    await flutterBlue.stopScan();
    print("Start scan");
    // Start scanning
    List<dynamic> foundDevices = await flutterBlue
        .startScan(
          timeout: const Duration(
            seconds: 30,
          ),
        )
        .asStream()
        .toList();
    await flutterBlue.stopScan();
    print("Scan end");
    for (dynamic devices in foundDevices) {
      for (ScanResult device in devices) {
        bluetoothDevices.add(device);
      }
    }
    return bluetoothDevices;
  }

  void idk() async {
    /*
    List<ScanResult> d = await bluetoothScan();
    setState(() {
      devices = d;
    });
    */
    //flutterBlue.stopScan();
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        print(tag.data.toString());
        int id1 = tag.data["nfca"]["identifier"][0];
        int id2 = tag.data["nfca"]["identifier"][1];
        int id3 = tag.data["nfca"]["identifier"][2];
        int id4 = tag.data["nfca"]["identifier"][3];
        String id =
            "${id1.toRadixString(16).padLeft(2, '0').toUpperCase()} ${id2.toRadixString(16).padLeft(2, '0').toUpperCase()} ${id3.toRadixString(16).padLeft(2, '0').toUpperCase()} ${id4.toRadixString(16).padLeft(2, '0').toUpperCase()}";
        print(id);
        print(id == "70 17 C1 80");
        final response = await dio.post(
            'http://10.10.11.204:5000/getdoctordata',
            data: FormData.fromMap({"uuid": id}));
        print(response);
        print(response.data);
        setState(() {
          animal = response.data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: animal["animalName"] == null
            ? const Text(
                "Please place tag near reader",
                style: TextStyle(fontSize: 24),
              )
            : Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      children: [
                        if (animal["AnimalType"] == "Dog")
                          const FaIcon(
                            FontAwesomeIcons.dog,
                            size: 96,
                          ),
                        if (animal["AnimalType"] == "Cat")
                          const FaIcon(
                            FontAwesomeIcons.cat,
                            size: 96,
                          ),
                        if (animal["AnimalType"] == "Kůň")
                          const FaIcon(
                            FontAwesomeIcons.horse,
                            size: 96,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Column(
                            children: [
                              Text(
                                animal["animalName"],
                                style: const TextStyle(
                                    fontSize: 38, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Year of birth: ${animal["birthdate"]}",
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Owner: ${animal["ownerFirstname"]} ${animal["ownerSecondname"]}",
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Phone number: ${animal["ownerNumber"]}",
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: const [
                        Text(
                          "Alergies:",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  for (String alergy in animal["alergies"])
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Row(
                        children: [
                          Text(
                            "• $alergy",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: const [
                        Text(
                          "Long term illnesses:",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  for (String illness in animal["longTermIllness"])
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Row(
                        children: [
                          Text(
                            "• $illness",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Row(
                      children: const [
                        Text(
                          "Injuries:",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  for (String injury in animal["injuries"])
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Row(
                        children: [
                          Text(
                            "• $injury",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  /*
            Text(
              "Animal: ${animal["AnimalType"]}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "Name: ${animal["animalName"]}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "Owner: ${animal["ownerFirstname"]} ${animal["ownerSecondname"]}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "Onwer phone number: ${animal["ownerNumber"]}",
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              "Year of birth: ${animal["birthdate"]}",
              style: const TextStyle(fontSize: 24),
            ),
            */
                  //for (ScanResult d in devices) Text(d.rssi.toString())
                ],
              ),
      ),
    );
  }
}
