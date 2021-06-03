import 'package:flutter/material.dart';

class MostEffectedPanel extends StatelessWidget {
  final List countryData;
  const MostEffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Image.network(
                    countryData[index]['countryInfo']['flag'],
                    height: 25,
                    width: 40,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Deaths : ',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        countryData[index]['deaths'].toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        countryData[index]['country'],
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: 5,
        ));
  }
}
