import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;

class CreateEvent extends StatefulWidget {
  //CreateEvent({Key? key}) : super(key: key);
  String userEmail;
  CreateEvent({required this.userEmail});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController _eventnameController = TextEditingController();
  final TextEditingController _eventdescController = TextEditingController();
  final TextEditingController _eventdateController = TextEditingController();
  final TextEditingController _eventaddressController = TextEditingController();
  final TextEditingController _eventTimeController = TextEditingController();

  getDay() {
    String date = _eventdateController.text.trim();
    List<String> dateParts = date.split('-');
    String day = dateParts[0]; // Access the first part
    print(day);
    return day;
  }

  registerAndSaveEventRecord() async {
      if (_eventnameController.text.trim().isEmpty ||
      _eventdescController.text.trim().isEmpty ||
      _eventdateController.text.trim().isEmpty ||
      _eventaddressController.text.trim().isEmpty ||
      _eventTimeController.text.trim().isEmpty) {
    Fluttertoast.showToast(msg: "Please fill all fields");
    return;
  }
    if(!isValidDate(_eventdateController.text.trim())) {
      Fluttertoast.showToast(msg: "Invalid date format");
      return;
    }
    try{
      var res = await http.post(
        Uri.parse(API.createEvent),
        body: <String, String>{
          'user_email': widget.userEmail,
          'event_name': _eventnameController.text.trim(),
          'event_desc': _eventdescController.text.trim(),
          //'event_date': _eventdateController.text.trim(),
          'event_date': _eventdateController.text.trim(),
          'event_address': _eventaddressController.text.trim(),
          'event_time': _eventTimeController.text.trim(),
          'created_by': widget.userEmail,
          }
      );
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        var resBodyOfSignup = jsonDecode(res.body);
        if(resBodyOfSignup['success'] == true) {
        Fluttertoast.showToast(msg: "Event Added successfully");}
      } else {
        Fluttertoast.showToast(msg: "Event Addition failed");
      }

    } catch (e) {
      print(e);
    }
  }
    bool isValidDate(String? value) {
      if (value == null || value.isEmpty) {
        return false;
      }

      final dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
      if (!dateRegExp.hasMatch(value)) {
        return false;
      }

      // Parse the date
      var parts = value.split('-');
      var year = int.parse(parts[0]);
      var month = int.parse(parts[1]);
      var day = int.parse(parts[2]);

      // Check if the month and day are valid
      if (month < 1 || month > 12) {
        return false;
      }

      var lastDayOfMonth = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > lastDayOfMonth) {
        return false;
      }

      return true;
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
    appBar: AppBar(
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
  ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),

                    const Text(
                      "Add Event",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _eventnameController,
                      decoration: InputDecoration(
                          hintText: "Event Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.title)),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _eventdescController,
                      decoration: InputDecoration(
                          hintText: "Event Description",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.description)),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _eventdateController,
                      decoration: InputDecoration(
                        hintText: "Date(yyyy-mm-dd)",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.date_range_outlined),
                      ),
                      obscureText: false,
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _eventaddressController,
                      decoration: InputDecoration(
                        hintText: "Address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.location_on_outlined),
                      ),
                      obscureText: false,
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _eventTimeController,
                      decoration: InputDecoration(
                          hintText: "Event Time",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.access_time_outlined)),
                    ),

                    const SizedBox(height: 20),

                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () {
                        registerAndSaveEventRecord();
                      },
                      child: const Text(
                        "Add Event",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}