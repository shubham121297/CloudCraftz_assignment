import 'package:flutter/material.dart';
import './business_form_screen.dart';

class MyHome extends StatelessWidget {
  void NavigateToBusinessForm(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return BusinessFormScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.network(
                'https://www.cloudcraftz.com/wp-content/uploads/2020/12/Cloudcraftz_logo-e1608656227668.png',
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 20, 15, 20),
              //padding: EdgeInsets.all(10),
              // alignment: Alignment.topLeft ,
              child: Text(
                'Welcome to QR generator',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 15, 20),
              //padding: EdgeInsets.all(15),
              child: Text(
                'We are excited to offer you a quick and easy way to create and download custom QR codes for your business card.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 10, 15, 20),
              child: Text(
                'We do not save your personal information and respect our users\' privacy',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: ElevatedButton(
                onPressed: () => NavigateToBusinessForm(context),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // <-- Radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
