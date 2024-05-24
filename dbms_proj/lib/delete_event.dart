import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:dbms_proj/api_connection/api_connection.dart';

class DeleteEvent extends StatelessWidget {
    final String eventId;
    DeleteEvent({required this.eventId});

    deleteEvent(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(API.deleteEvent),
        body: <String, String>{
          'event_id': eventId,
        },
      );
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        if(res.body.isNotEmpty) {
        var resBody = jsonDecode(res.body.toString());
        if(resBody['success'] == true) {
          Fluttertoast.showToast(msg: "Deletion successful");
        } else {
          Fluttertoast.showToast(msg: "Deletion failed");
        }
      }
      } else {
        Fluttertoast.showToast(msg: "Deletion failed");
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
        title: Text('Delete Event'),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Are you sure you want to delete?',
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
            deleteEvent(context);
          },
          child: Text(
            'Delete Event',
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