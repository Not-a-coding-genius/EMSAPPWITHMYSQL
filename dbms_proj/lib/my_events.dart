import 'package:dbms_proj/unregister.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'unregister.dart';

class MyEvents extends StatefulWidget {
  final String useremail;

  MyEvents({required this.useremail});

  @override
  _MyEventsState createState() => _MyEventsState();
}
String event_name = '';

class _MyEventsState extends State<MyEvents> {
  Future<List<dynamic>> fetchEvents() async {
    var res = await http.post(
      Uri.parse(API.getUserEvents),
      body: <String, String>{
        'user_email': widget.useremail,
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('Failed to load events');
    }
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xff102733),
    appBar: AppBar(
      title: Text('My Events'),
    ),
    body: FutureBuilder<List<dynamic>>(
      future: fetchEvents(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color:  Color.fromARGB(255, 42, 64, 77),
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => UnregisterPage(useremail: widget.useremail,)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/tileimg.png',
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          snapshot.data[index]['event_name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        String eventName = snapshot.data[index]['event_name'];
                        print(eventName);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => UnregisterPage(useremail: widget.useremail, eventname: eventName)));
                },
                child: Text('Unregister'),)
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    ),
  );
}
}