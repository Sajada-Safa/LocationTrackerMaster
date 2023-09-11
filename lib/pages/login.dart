// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location_tracker/pages/location_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var uidCtrl = TextEditingController();
  var passwordCtrl = TextEditingController();
  String uidText = '';
  String passwordText = '';

  Map<String, dynamic> data = {
    // 'id': '3',
  };
  handleAPi() async {
    String apiUrl =
        'https://7tonexpress.com/locationtesting/check?uuid=${uidCtrl.text}';

    Map<String, dynamic> data = {
      // 'id': '3',
    };

    print('post started');

    try {
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

      final request = await client.postUrl(Uri.parse(apiUrl));
      request.headers.add('Accept', '/');

      request.write(jsonEncode(data));

      final response = await request.close();

      final responseBody = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        print('Response data: $responseBody');
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> TrackerPage(uuid: uidCtrl.text,)));
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response data: $responseBody');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<String> uidList = ['123', '234', '345'];

  void handleLogin(String uid, String password) async {
    // bool uidExist = uidList.contains(uid);
    try {
      await handleAPi();
    } catch (e) {
      print(e);
    }
    // if (uidExist) {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (BuildContext context) => TrackerPage()));
    //   print('This user exist');
    // } else {
    //   print("Doesn't exist");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter uuid'),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter User ID',
                ),
                controller: uidCtrl,
              ),
              SizedBox(
                height: 20,
              ),
              Text('Enter password'),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                ),
                controller: passwordCtrl,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      uidText = uidCtrl.text;
                      passwordText = passwordCtrl.text;
                    });
                    handleLogin(uidCtrl.text, passwordCtrl.text);
                  },
                  child: Text('Log In'))
            ],
          ),
        ),
      ),
    );
  }
}
