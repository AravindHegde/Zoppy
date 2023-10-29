import 'package:flutter/material.dart';
import 'package:zoppyui/Utility/constants.dart' as constants; 

class Usermanager extends StatefulWidget {
  const Usermanager({Key? key}) : super(key: key);

  @override
  _UsermanagerState createState() => _UsermanagerState();
}

class _UsermanagerState extends State<Usermanager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor : constants.themeColorCode,
        flexibleSpace: Center(
          child: Image.asset('assets/images/logo.png',
          fit: BoxFit.fill),
        ) // Replace 'logo.png' with the actual path to your logo image.
      ),
      body:  Stack(
        children: [
            SingleChildScrollView(

            )
        ]
      )
    );
  }
}