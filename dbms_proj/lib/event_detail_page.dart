import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'event_details_background.dart';
import 'event_details_content.dart';
import 'data.dart';
import 'events_model.dart';

class EventDetailsPage extends StatelessWidget {

  final EventsModel event;
  String useremail;
  String IsAdmin;
  EventDetailsPage({required this.event,required this.useremail,required this.IsAdmin});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff102733),
        appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
              child: EventDetailsBackground(event: event),
              ),
              EventDetailsContent(event: event,useremail: useremail,IsAdmin: IsAdmin),
            ],
          ),
        ),
      );
  }
}