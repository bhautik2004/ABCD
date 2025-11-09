import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpreferences_example/load_users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Shared preferences Demo '),
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String gender = "Male";
  String result = "";
  List<Map<String, dynamic>> _users = [];

  Future<void> SaveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? existingData = pref.getString("users");
    if (existingData != null) {
      _users = List<Map<String, dynamic>>.from(json.decode(existingData));
    }

    _users.add({
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'age': ageController.text,
      'gender': gender,
    });

    await pref.setString("users", json.encode(_users));

    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();

    setState(() {
      result = "DATA SAVED Successfully..";
    });
  }


  void LoadData() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoadUser()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "FirstName"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: "LastName"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "age"),
            ),

            Row(
              children: [
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text("Male"),
                Radio(
                  value: "FeMale",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text("FeMale"),
              ],
            ),
            ElevatedButton(onPressed: SaveData, child: Text("SAVE DATA")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: LoadData, child: Text("LOAD DATA")),
            Text(result),
          ],
        ),
      ),
    );
  }
}
