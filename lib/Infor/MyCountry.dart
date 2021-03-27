import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app2/panels/world_wide.dart';
import 'package:flutter/cupertino.dart';

class MyCountry1 extends StatefulWidget {
  @override
  _MyCountryState createState() => _MyCountryState();
}

class _MyCountryState extends State<MyCountry1> {
  Map VNData;
  Future fetchVietnamData() async {
    http.Response response = await http.get('https://disease.sh/v3/covid-19/countries/Vietnam?yesterday=true&twoDaysAgo=false&strict=false&allowNull=true');
    setState(() {
      VNData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchVietnamData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VNData == null
                ? CircularProgressIndicator()
                : VietnamPanel(VNData: VNData,),
          ],
        ),
      ),
    );
  }
}
