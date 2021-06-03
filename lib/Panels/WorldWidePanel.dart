import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  final Map worldData;
  const WorldWidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.grey[300],
      child: Container(
          child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: [
          StatusPanel(
            title: 'CONFIRMED',
            textColor: Colors.purple,
            count: worldData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            textColor: Colors.orange,
            count: worldData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            textColor: Colors.green,
            count: worldData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATH',
            textColor: Colors.red,
            count: worldData['deaths'].toString(),
          )
        ],
      )),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor = Colors.white;
  final Color countColor = Colors.black;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel({
    Key key,
    this.textColor,
    this.title,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: textColor,
                letterSpacing: 2),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: countColor),
          )
        ],
      ),
    );
  }
}
