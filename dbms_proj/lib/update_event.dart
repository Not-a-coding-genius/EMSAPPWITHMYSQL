import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;

class UpdateEvent extends StatefulWidget {
  //CreateEvent({Key? key}) : super(key: key);
  String userEmail;
  String eventName;
  String eventDesc;
  String eventDate;
  String eventAddress;
  String eventTime;
  String eventId;
  UpdateEvent({required this.userEmail,required this.eventName,required this.eventDesc,required this.eventDate,required this.eventAddress,required this.eventTime,required this.eventId});

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  late TextEditingController _eventnameController;
  late TextEditingController _eventdescController;
  late TextEditingController _eventdateController;
  late TextEditingController _eventaddressController;
  late TextEditingController _eventTimeController;

@override
  void initState() {
    super.initState();
    _eventnameController = TextEditingController(text: widget.eventName);
    _eventdescController = TextEditingController(text: widget.eventDesc);
    _eventdateController = TextEditingController(text: widget.eventDate);
    _eventaddressController = TextEditingController(text: widget.eventAddress);
    _eventTimeController = TextEditingController(text: widget.eventTime);
  }


  getDay() {
    String date = _eventdateController.text.trim();
    List<String> dateParts = date.split('-');
    String day = dateParts[0]; // Access the first part
    print(day);
    return day;
  }

  registerAndSaveEventRecord() async {
    try{
      var res = await http.post(
        Uri.parse(API.UpdateEvent),
        body: <String, dynamic>{
          'user_email': widget.userEmail,
          'event_name': _eventnameController.text.trim(),
          'event_desc': _eventdescController.text.trim(),
          //'event_date': _eventdateController.text.trim(),
          'event_date': _eventdateController.text.trim(),
          'event_address': _eventaddressController.text.trim(),
          'event_time': _eventTimeController.text.trim(),
          'event_id': widget.eventId,
          }
      );
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        var resBodyOfSignup = jsonDecode(res.body);
        if(resBodyOfSignup['success'] == true) {
        Fluttertoast.showToast(msg: "Event Updated successfully");}
      } else {
        Fluttertoast.showToast(msg: "Event Updated failed");
      }

    } catch (e) {
      print(e);
    }
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
                      "Update Event",
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
                          hintText: "${widget.eventName}",
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
                          hintText: "${widget.eventDesc}",
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
                        hintText: "Date(dd-mm-yyyy)",
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
                        hintText: "${widget.eventAddress}",
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
                          hintText:"${widget.eventTime}",
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
                        "Update Event",
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