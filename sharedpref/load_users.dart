import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _loadUserScreen();
}
class _loadUserScreen extends State<LoadUser> {

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    LoadData();
  }
  Future<void> LoadData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? userData = pref.getString("users");

    setState(() {
      // result = "FirstName : ${firstname ?? ''}\n LastName : ${lastname?? ''} \n Age : ${age?? ''}\n Gender : ${gender}";
      _users = List<Map<String, dynamic>>.from(json.decode(userData!));
    });
  }
  Future<void> ClearAllData() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('users');
    setState(() {
      _users.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Users"),
        actions: [
          IconButton(onPressed: ClearAllData, icon: Icon(Icons.delete_forever))
        ],

      ),
      body: _users.isEmpty
          ? Center(child: Text('No User Found'))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text('${user['firstname']} ${user['lastname']}'),
                  subtitle: Text(
                    'age: ${user['age']} gender : ${user['gender']} ',
                  ),
                );
              },
            ),

    );
  }


}
