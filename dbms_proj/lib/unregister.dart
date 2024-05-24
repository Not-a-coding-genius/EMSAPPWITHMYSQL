import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:dbms_proj/api_connection/api_connection.dart';

class UnregisterPage extends StatelessWidget {
    final String useremail;
    final String eventname;
    UnregisterPage({required this.useremail, required this.eventname});

    UnRegister(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(API.unregisterEvent),
        body: <String, String>{
          'user_email': useremail,
          'event_name': eventname,
        },
      );
      print(eventname);
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        if(res.body.isNotEmpty) {
        var resBody = jsonDecode(res.body.toString());
        if(resBody['success'] == true) {
          Fluttertoast.showToast(msg: "Unregister successful");
        } else {
          Fluttertoast.showToast(msg: "Unregister failed");
        }
      }
      } else {
        Fluttertoast.showToast(msg: "Unregister failed");
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff102733),
      appBar: AppBar(
        title: Text('Unregister'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Are you sure you want to unregister?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          ),
          onPressed: () {
            UnRegister(context);
          },
          child: Text(
            'Unregister',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ],
      ),
      ),
    );
  }
}