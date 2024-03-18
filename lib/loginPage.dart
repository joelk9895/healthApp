import 'package:flutter/material.dart';
import 'package:health/layer1.dart';
import 'package:health/layer2.dart';
import 'package:health/layer3.dart';
import 'package:health/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    // Perform login logic here
    setState(() {
      _isLoading = true;
      // Simulate a delay for demonstration purposes
      Future.delayed(const Duration(seconds: 2), () {
        // After the login process is completed, stop loading
        setState(() {
          _isLoading = false;
        });
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                stops: [0.001, 0.1, 0.8, 0.9],
                colors: [
                  Color(0xFF00B686),
                  Colors.white,
                  Colors.white,
                  Colors.blueAccent,
                ],
              )),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 200,
                      left: 59,
                      child: Container(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      )),
                  Positioned(top: 290, right: 0, bottom: 0, child: LayerOne()),
                  Positioned(
                      top: 318, right: 15, bottom: 28, child: LayerTwo()),
                  Positioned(
                      top: 320, right: 0, bottom: 48, child: LayerThree()),
                ],
              ),
            ),
    );
  }
}
