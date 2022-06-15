import 'package:Music_player/home.dart';
import 'package:flutter/material.dart';

class Screensplah extends StatefulWidget {
  const Screensplah({Key? key}) : super(key: key);

  @override
  State<Screensplah> createState() => _ScreensplahState();
}

class _ScreensplahState extends State<Screensplah> {
  @override
  void initState() {
    gohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/assa.webp"),
          ),
        ],
      ),
    );
  }

  Future<void> gohome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MyHomePages(),
    ));
  }
}