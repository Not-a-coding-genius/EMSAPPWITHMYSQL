
import 'package:dbms_proj/homepage.dart';
import 'package:flutter/material.dart';
import 'package:dbms_proj/signuppage.dart';
import 'package:http/http.dart' as http;
import 'package:dbms_proj/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart' ;
import 'dart:convert';
import 'forgot_password.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  loginUser(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: <String, String>{
          'user_email': _emailController.text.trim(),
          'user_password': _passwordController.text.trim(),
        },
      );
      print(res.body);
      print(res.statusCode);
      if(res.statusCode == 200) {
        var resBody = jsonDecode(res.body);
        var userName = resBody['userData']['user_name'];
        var IsAdmin = resBody['userData']['IsAdmin'];
        print(userName);
        if(resBody['login'] == true) {
          Fluttertoast.showToast(msg: "Login successful");
          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen(useremail: _emailController.text.trim(),userName:userName,IsAdmin: IsAdmin)));
        } else {
          Fluttertoast.showToast(msg: "Login failed");
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
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
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
              hintText: "Email",
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
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            loginUser(context);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword()));
      },
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.green),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
            },
            child: const Text("Sign Up", style: TextStyle(color: Colors.green),)
        )
      ],
    );
  }
}