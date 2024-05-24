import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../styleguide.dart';
import 'data.dart';
import 'events_model.dart';
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'dart:convert';
import 'package:http/http.dart' as http;


class EventDetailsContent extends StatelessWidget {

  final EventsModel event;
  String useremail;
  String IsAdmin;
  EventDetailsContent({required this.event,required this.useremail,required this.IsAdmin});

  void registerAndSaveEvent() async {
  try {
    var res = await http.post(
      Uri.parse(API.addParticipant),
      body: <String, dynamic>{
        'user_email': useremail,
        'event_name': event.desc,
        'event_id': event.id,
      },
    );
    print(res.body);
    print(res.statusCode);

    if (res.statusCode == 200) {
      var resBody = jsonDecode(res.body);
      if (resBody['success'] == true) {
        Fluttertoast.showToast(msg: "Event registered successfully");
      } else if (resBody['error'] == 'Error in adding participant') {
        Fluttertoast.showToast(msg: "You have already registered");
      }
    } else {
      Fluttertoast.showToast(msg: "Event registration failed");
    }
  } catch (e) {
    print(e);
  }
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(
              event.desc,
              style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Text(
                    "-",
                    style: eventLocationTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    event.address,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          SizedBox(
      height: 80,
    ),
      Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.all(10.0),
        child: ElevatedButton(
        onPressed: () {
          //registerAndSaveEvent();
      if (IsAdmin == "Yes") {
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Admin Account'),
              content: Text('Please login from a student account to register.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        registerAndSaveEvent();
      }

        },
        child: Text('Participate!'),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
        ),
            ),
      ),
    ]
    ),
  );
}
}