
import 'package:dbms_proj/signuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50 ,
              ),
              Text("Welcome to EMS!",style: TextStyle(
                color: Colors.white ,
                fontSize: 27 ,
                fontWeight: FontWeight.w700 ,
              ),),
              Text("Event Management System",style: TextStyle(
                fontSize: 16,
              )),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15,right:15),
                child: Image.asset('assets/onboardIcon.png'),
              ),
                SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5 ,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(5) ,topRight:Radius.circular(5) ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(left: 15,right: 15),
                        child: Text("The social media platform desgined to get you offline",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                        Padding(
                        padding:EdgeInsets.only(left: 15,right: 15),
                        child: Text("EMS app is an app where users can leverage social netword to create,discover,share and monetize events or services.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 15),
                        child: MaterialButton(color: Colors.white, elevation:2, minWidth: double.infinity, onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
                        }, child: Text("Get Started", style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff274560),
                          fontWeight: FontWeight.w500,
                        ),)),
                      )
                    ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}