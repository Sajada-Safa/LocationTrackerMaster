// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_declarations, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key, required this.uuid});
  final String uuid;

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  Future<void> fetchData() async {
    final response = await http.post(Uri.parse(
        "https://7tonexpress.com/locationtesting/update?uuid=0268957591&duid=245634567&time=1693746572854&lat=23.796176&lon=90.373452"));

    if (response.statusCode == 200) {
      // Successful request
      print('Response data: ${response.body}');
    } else {
      // Handle errors
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // _handleUpdateApi() async {
  //   final updateApiUri =
  //       'https://7tonexpress.com/locationtesting/update?uuid=7808793093&duid=245634567&time=1693746572854&lat=23.791176&lon=90.371452';
  //   Map<String, dynamic> data = {
  //     // 'id': '3',
  //   };

  //   print('post started');

  //   try {
  //     HttpClient client = HttpClient()
  //       ..badCertificateCallback =
  //           (X509Certificate cert, String host, int port) => true;

  //     final request = await client.postUrl(Uri.parse(updateApiUri));
  //     request.headers.add('Accept', '/');

  //     request.write(jsonEncode(data));

  //     final response = await request.close();

  //     final responseBody = await response.transform(utf8.decoder).join();

  //     if (response.statusCode == 200) {
  //       print('Response data: $responseBody');
  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //         builder: (BuildContext context) => TrackerPage()));
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       print('Response data: $responseBody');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Location Tracker'),
      ),
    );
  }
}
