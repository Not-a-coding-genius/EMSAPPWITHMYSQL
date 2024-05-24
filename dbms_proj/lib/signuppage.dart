
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dbms_proj/loginpage.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;

class SignupPage extends StatefulWidget {
  SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Future<void> validateUserEmail() async {
    try {
      if(!checkEmailFormat()) {
        Fluttertoast.showToast(msg: "Invalid email format");
        return;
      }
      var res = await http.post(
        Uri.parse(API.validateEmail),
        body: <String, String>{
          'user_email': _emailController.text.trim(),
        },
      );
      if(res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if(resBody['emailFound'] == true) {
          Fluttertoast.showToast(msg: "Email already exists");
        } else {
          registerAndSaveUserRecord();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  bool checkEmailFormat() {
    final RegExp regex = RegExp(
    r'^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'
  );
    return regex.hasMatch(_emailController.text.trim());
  }

  registerAndSaveUserRecord() async {

    try{
      var res = await http.post(
        Uri.parse(API.signUp),
        body: <String, String>{
          'user_email': _emailController.text.trim(),
          'user_name': _usernameController.text.trim(),
          'user_password': _passwordController.text.trim(),}
      );
      if(res.statusCode == 200) {
        var resBodyOfSignup = jsonDecode(res.body);
        if(resBodyOfSignup['success'] == true) {
        Fluttertoast.showToast(msg: "User registered successfully");}
      } else {
        Fluttertoast.showToast(msg: "User registration failed");
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
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person)),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.green.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.green.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () {
                        validateUserEmail();
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                      ),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.green),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}