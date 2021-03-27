
import 'package:flutter/material.dart';

class VietnamPanel extends StatelessWidget {
  final Map VNData;

  const VietnamPanel({Key key, this.VNData}) : super(key: key);
  @override 
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: VNData["cases"].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            count: VNData["active"].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: VNData["recovered"].toString(),
          ),
          StatusPanel(
            title: 'DEATHS',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: VNData["deaths"].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;
  const StatusPanel({Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
        bottomLeft: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
      )),
      margin: EdgeInsets.all(10),
      height: 80, width: width/2,
      // color: Colors.blue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold,
            color: textColor,
            fontSize: 19.0,
            ),),
          SizedBox(height: 8.0,),
          Text(
            count,
            style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, color: textColor),
          )
        ],
      ),
    );
  }
}
