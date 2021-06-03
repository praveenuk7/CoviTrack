import 'package:covi_track/Pages/FAQs.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../DataSource.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RaisedButton bottomBarButton({String url, String buttonName}) {
      return RaisedButton(
        shape: StadiumBorder(),
        onPressed: () {
          launch(url);
        },
        child: Text(buttonName),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: primaryBlack,
          //color: Colors.teal[300],

          boxShadow: [
            BoxShadow(spreadRadius: 1, color: Colors.grey, blurRadius: 1)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton(
            shape: StadiumBorder(),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FAQPage()));
            },
            child: Text('FAQs'),
          ),
          bottomBarButton(
              url: 'https://selfregistration.cowin.gov.in/',
              buttonName: 'VACCINE'),
          bottomBarButton(
              url: 'https://covid19responsefund.org/en/', buttonName: 'DONATE')
        ],
      ),
    );
  }
}
