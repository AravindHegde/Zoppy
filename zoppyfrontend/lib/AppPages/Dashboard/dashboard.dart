import 'package:flutter/material.dart';
import 'package:zoppyui/Utility/constants.dart' as constants;
import 'package:zoppyui/AppPages/UserManagement/usermanager.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor : constants.themeColorCode,
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/logo.png',fit: BoxFit.fill),
            Container(
              padding: const EdgeInsets.only(right : 10.0),
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.white,
                  
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Usermanager(),
                  ));
                },
              ),
            ) ,
          ]
        ) 
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