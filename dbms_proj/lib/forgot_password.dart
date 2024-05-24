import 'package:dbms_proj/homepage.dart';
import 'package:flutter/material.dart';
import 'package:dbms_proj/signuppage.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'dart:convert';
import 'loginpage.dart';



class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  resetPassword(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(API.forgotPassword),
        body: <String, dynamic>{
          'userid': _emailController.text.trim(),
          'user_password': _passwordController.text.trim(),
        },
      );
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        if(resBody['success'] == true) {
          Fluttertoast.showToast(msg: "Reset successful");
          Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
        } else {
          Fluttertoast.showToast(msg: "Reset failed");
        }
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
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Forgot your password?",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              hintText: "UserId",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none
              ),
              fillColor: Colors.green.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "New Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.green.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            resetPassword(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
          ),
          child: const Text(
            "Set Password",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
      },
      child: const Text("",
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Contact your admin for your further queries."),
      ],
    );
  }
}