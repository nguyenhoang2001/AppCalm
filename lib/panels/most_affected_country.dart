import 'package:flutter/material.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;
  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // return DataTable(
          //     rows: <DataRow>[
          //       DataRow(
          //         cells: [
          //           DataCell(Image.network(countryData[index]['countryInfo']['flag'], scale: 2,)),
          //           DataCell(Text(countryData[index]['country'].toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),),),
          //           DataCell(Text('Cases: ' + countryData[index]['cases'].toString(),style: TextStyle( color: Colors.white, fontSize: 20),),),
          //         ]
          //       ),
          //     ],
          //     columns: [
          //       DataColumn(label: Text('')),
          //       DataColumn(label: Text('')),
          //       DataColumn(label: Text('')),
          // ],
          // );
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: <Widget>[
                Image.network(
                  countryData[index]['countryInfo']['flag'],
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  countryData[index]['country'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 21
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Cases:' + countryData[index]['cases'].toString(),
                  style:
                  TextStyle(
                    color: Colors.red[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                )
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
