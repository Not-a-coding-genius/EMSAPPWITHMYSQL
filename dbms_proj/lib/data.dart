import 'package:intl/intl.dart';
import 'date_model.dart';
import 'event_type_model.dart';
import 'events_model.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'dart:convert';

List<DateModel> getDates(){

  List<DateModel> dates = <DateModel>[];
  DateModel dateModel = new DateModel();
  DateTime currentDate = DateTime.now();

  String date = DateFormat('d').format(currentDate);
  String day = DateFormat('EEE').format(currentDate);
  String whole = DateFormat('yyyy-MM-dd').format(currentDate);

  //1
  dateModel.date = date;
  dateModel.weekDay = day;
  dateModel.whole = whole;
  dates.add(dateModel);

  dateModel = new DateModel();

  currentDate = currentDate.add(Duration(days: 1));

  String date1 = DateFormat('d').format(currentDate);
  String day1 = DateFormat('EEE').format(currentDate);
  String whole1 = DateFormat('yyyy-MM-dd').format(currentDate);

  //1
  dateModel.date = date1;
  dateModel.weekDay = day1;
  dateModel.whole = whole1;
  dates.add(dateModel);

  dateModel = new DateModel();

 currentDate = currentDate.add(Duration(days: 1));

  String date2 = DateFormat('d').format(currentDate);
  String day2 = DateFormat('EEE').format(currentDate);
  String whole2 = DateFormat('yyyy-MM-dd').format(currentDate);


  //1
  dateModel.date = date2;
  dateModel.weekDay =  day2;
  dateModel.whole = whole2;
  dates.add(dateModel);

  dateModel = new DateModel();

  currentDate = currentDate.add(Duration(days: 1));

  String date3 = DateFormat('d').format(currentDate);
  String day3 = DateFormat('EEE').format(currentDate);
  String whole3 = DateFormat('yyyy-MM-dd').format(currentDate);

  //1
  dateModel.date = date3;
  dateModel.weekDay = day3;
  dateModel.whole = whole3;
  dates.add(dateModel);

  dateModel = new DateModel();

  currentDate = currentDate.add(Duration(days: 1));

  String date4 = DateFormat('d').format(currentDate);
  String day4 = DateFormat('EEE').format(currentDate);
  String whole4 = DateFormat('yyyy-MM-dd').format(currentDate);


  //1
  dateModel.date = date4;
  dateModel.weekDay = day4;
  dateModel.whole = whole4;
  dates.add(dateModel);

  dateModel = new DateModel();

  currentDate = currentDate.add(Duration(days: 1));

  String date5 = DateFormat('d').format(currentDate);
  String day5 = DateFormat('EEE').format(currentDate);
  String whole5 = DateFormat('yyyy-MM-dd').format(currentDate);


  //1
  dateModel.date = date5;
  dateModel.weekDay = day5;
  dateModel.whole = whole5;
  dates.add(dateModel);

  dateModel = new DateModel();

  currentDate = currentDate.add(Duration(days: 1));

  String date6 = DateFormat('d').format(currentDate);
  String day6 = DateFormat('EEE').format(currentDate);
  String whole6 = DateFormat('yyyy-MM-dd').format(currentDate);


  //1
  dateModel.date = date6;
  dateModel.weekDay =  day6;
  dateModel.whole = whole6;
  dates.add(dateModel);

  dateModel = new DateModel();

  return dates;

}

List<EventTypeModel> getEventTypes(){

  List<EventTypeModel> events = <EventTypeModel>[];
  EventTypeModel eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/concert.png";
  eventModel.eventType = "concert";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/sports.png";
  eventModel.eventType = "sports";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  //1
  eventModel.imgAssetPath = "assets/education.png";
  eventModel.eventType = "education";
  events.add(eventModel);

  eventModel = new EventTypeModel();

  return events;
}


/*Future<List<EventsModel>> getEvents1(String selectedDate) async {
  List<EventsModel> events1 = <EventsModel>[];
  var res = await http.post(
  Uri.parse(API.getevents),
          body: <String, String>{
          'event_date': selectedDate.toString(),
        },
      );
  print(selectedDate);
  print(res.body);
  print(res.statusCode);
  if (res.statusCode == 200) {
  List<dynamic> data = await json.decode(res.body);

  if(data.isNotEmpty) {
  data.forEach((eventData) {
    if(eventData['event_date']==selectedDate) {
    EventsModel eventsModel = new EventsModel();
    eventsModel.imgeAssetPath = "assets/tileimg.png";
    eventsModel.date = eventData['event_date'];
    eventsModel.desc = eventData['event_name'];
    eventsModel.address = eventData['event_address'];
    eventsModel.time = eventData['event_time'];
    eventsModel.id = eventData['event_id'];
    events1.add(eventsModel);
    }
  });
}
}
  //getEvents(selectedDate);
  return events1;
} */

Future<List<EventsModel>> getEvents1(String selectedDate) async {
  List<EventsModel> events1 = <EventsModel>[];
  var res = await http.post(
  Uri.parse(API.getevents),
          body: <String, String>{
          'event_date': selectedDate.toString(),
        },
      );
  print(selectedDate);
  print(res.body);
  print(res.statusCode);
  if (res.statusCode == 200) {
  List<dynamic> data = await json.decode(res.body);
  if(data.isNotEmpty) {
  data.forEach((eventData) {
  String eventDate = eventData['event_date'];
    if(eventDate==selectedDate) {
    EventsModel eventsModel = new EventsModel();
    eventsModel.imgeAssetPath = "assets/tileimg.png";
    eventsModel.date = eventData['event_date'];
    eventsModel.desc = eventData['event_name'];
    eventsModel.address = eventData['event_address'];
    eventsModel.time = eventData['event_time'];
    eventsModel.id = eventData['event_id'];
    events1.add(eventsModel);
    }
  });
}
}
  //getEvents(selectedDate);
  return events1;
}

Future<List<EventsModel>> getEvents(String selectedDate) async{

  List<EventsModel> events = <EventsModel>[];
  List<EventsModel> eventstemp = await getEvents1(selectedDate);

  if(eventstemp.isEmpty) {
    return events;
  }

    for (int i = 0; i < eventstemp.length; i++) {
    EventsModel eventsModel = new EventsModel();
    eventsModel.imgeAssetPath = eventstemp[i].imgeAssetPath;
    eventsModel.date = eventstemp[i].date;
    eventsModel.desc = eventstemp[i].desc;
    eventsModel.address = eventstemp[i].address;
    events.add(eventsModel);
  }

  return events;


}

