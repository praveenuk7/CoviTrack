import 'dart:convert';
import 'package:covi_track/Panels/BottomNavBar.dart';
import 'package:covi_track/Panels/MostEffectedCountries.dart';
import 'package:covi_track/Panels/WorldWidePanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;

import '../DataSource.dart';
import 'CountryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse("https://corona.lmao.ninja/v3/covid-19/countries?sort=cases"));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavBar(),
        appBar: AppBar(
          title: Text('COV-i-TRaCk'),
        ),
        body: RefreshIndicator(
          onRefresh: fetchData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  height: 80,
                  //color: Colors.orange[100],

                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'images/nurse.png',
                        ),
                      ),
                      Expanded(
                        child: Text(
                          DataSource.quote,
                          style: TextStyle(
                              color: Colors.orange[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Global Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: primaryBlack,
                            shape: StadiumBorder(),
                            elevation: 10),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountryPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.all(3),
                          height: 40,
                          decoration: BoxDecoration(
                              color: primaryBlack,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text(
                              'All Countries',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                worldData == null
                    ? Center(child: CircularProgressIndicator())
                    : WorldWidePanel(
                        worldData: worldData,
                      ),
                SizedBox(
                  height: 10,
                ),

                Center(
                  child: Text(
                    "LETS'S FIGHT IT BY DISTANCE",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.amber,
                        letterSpacing: 2),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text(
                    'Most Affected Countries',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                countryData == null
                    ? Center(child: CircularProgressIndicator())
                    : MostEffectedPanel(
                        countryData: countryData,
                      ),
                //InfoPanel(),
                SizedBox(
                  height: 5,
                ),
                // Center(
                //   child: Text(
                //     "LETS'S FIGHT IT BY DISTANCE",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
