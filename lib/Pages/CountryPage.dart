import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Search.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              })
        ],
        title: Text('Country Stats'),
      ),
      body: countryData == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.black12,
                  elevation: 5,
                  child: Container(
                    height: 130,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey[100],
                          blurRadius: 10,
                          offset: Offset(0, 10))
                    ]),
                    child: Row(
                      children: [
                        Container(
                          width: 140,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                countryData[index]['country'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 50,
                                width: 60,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFIRMED:' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Text(
                                'ACTIVE:' +
                                    countryData[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                'RECOVERED:' +
                                    countryData[index]['recovered'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                'DEATHS:' +
                                    countryData[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
              itemCount: countryData == null ? 0 : countryData.length,
            ),
    );
  }
}
