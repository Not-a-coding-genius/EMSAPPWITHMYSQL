import 'package:dbms_proj/create_event.dart';
import 'package:dbms_proj/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'data.dart';
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'date_model.dart';
import 'event_type_model.dart';
import 'events_model.dart';
import 'package:intl/intl.dart';
import 'event_detail_page.dart';
import 'my_events.dart';
import 'admin_events.dart';
class HomeScreen extends StatefulWidget {
  final String useremail;
  final String userName;
  final String IsAdmin;

  HomeScreen({required this.useremail,required this.userName,required this.IsAdmin});

  //HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<DateModel> dates = <DateModel>[];
  List<EventTypeModel> eventsType = <EventTypeModel>[];
  List<EventsModel> eventsForDate = <EventsModel>[];



  //String todayDateIs =  DateFormat('d').format(DateTime.now());
  String todayDateIs = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String selectedEventType = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = getDates();
    eventsType = getEventTypes();
    //events = getEvents();
    initializeEvents();
  }

Future<void> initializeEvents() async {
  eventsForDate = await getEvents1(todayDateIs);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
              color: Color(0xff102733)
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
                            },
                          child: Image.asset("assets/logo.png",height: 28,)),
                        SizedBox(width: 8,),
                        Row(
                          children: <Widget>[
                            Text("EMS", style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w800
                            ),),
                            Text("APP", style: TextStyle(
                                color: Color(0xffFCCD00),
                                fontSize: 22,
                                fontWeight: FontWeight.w800
                            ),)
                          ],
                        ),
                        Spacer(),
                        SizedBox(width: 16,),
                      ],
                    ),
                    SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Hello, ${widget.userName}", style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 21
                              ),),
                              SizedBox(height: 6,),
                              Text("Let's explore what’s happening nearby",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15
                              ),)
                            ],
                          ),
                          Spacer(),
                          IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                          if(widget.IsAdmin == 'Yes') {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => AdminPage(useremail: widget.useremail)));
                          }
                          else {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyEvents(useremail: widget.useremail)));
                          }
                          },
                          ),
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color:  Color(0xff102733)
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )
                        ],
                      ),
                    SizedBox(height: 20,),

                    /// Dates
                    Container(
                      height: 60,
                      child: ListView.builder(
                          itemCount: dates.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return GestureDetector(
                              onTap: (){
                                setState(() {
                                  //todayDateIs = dates[index].date;
                                  todayDateIs = dates[index].whole;
                                  initializeEvents();
                                });
                              },
                              child: DateTile(
                                weekDay: dates[index].weekDay,
                                date: dates[index].date,
                                isSelected: todayDateIs == dates[index].whole,
                              ),
                            );
                          }),
                    ),

                    /// Popular Events
                    SizedBox(height: 16,),
                    Text("All Events", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),),
                    Container(
                      height:800,
                      child: eventsForDate.isEmpty? Center(child: Text("No events found")): ListView.builder(
                        itemCount: eventsForDate.length,
                          shrinkWrap: true,
                          itemBuilder: (Buildcontext, int index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsPage(event: eventsForDate[index],useremail: widget.useremail,IsAdmin: widget.IsAdmin,)));
                            },
                            child: PopularEventTile(
                              desc: eventsForDate[index].desc,
                              imgeAssetPath: eventsForDate[index].imgeAssetPath,
                              //date: eventsForDate[index].date,
                              address: eventsForDate[index].address,
                            ),
                          );
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: widget.IsAdmin == 'Yes' ? FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEvent(userEmail: widget.useremail)));
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xffFCCD00),
      ): null,
    );
  }
}

class DateTile extends StatelessWidget {

  String weekDay;
  String date;
  late bool isSelected;
  DateTile({required this.weekDay, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xffFCCD00) : Colors.transparent,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(date, style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600
          ),),
          SizedBox(height: 10,),
          Text(weekDay, style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}


class PopularEventTile extends StatelessWidget {

  String desc;
  String date ='';
  String address;
  String imgeAssetPath;/// later can be changed with imgUrl
  //PopularEventTile({required this.address,required this.date,required this.imgeAssetPath, required this.desc});
  PopularEventTile({required this.address, required this.imgeAssetPath, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff29404E),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(desc, style: TextStyle(
                      color: Colors.white,
                    fontSize: 18
                  ),),
                  SizedBox(height: 8,),
                  Row(
                    children: <Widget>[
                      //Image.asset("assets/calender.png", height: 12,),
                      //SizedBox(width: 8,),
                      Text(date, style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      ),)
                    ],
                  ),
                  //SizedBox(height: 4,),
                  Row(
                    children: <Widget>[
                      Image.asset("assets/location.png", height: 12,),
                      SizedBox(width: 8,),
                      Text(address, style: TextStyle(
                        color: Colors.white,
                        fontSize: 10
                      ),)
                    ],
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
              child: Image.asset(imgeAssetPath, height: 100,width: 120, fit: BoxFit.cover,)),
        ],
      ),
    );
  }
}