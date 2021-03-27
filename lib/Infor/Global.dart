import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app2/panels/global.dart';
import 'dart:convert';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Map worldData;
  Future fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(worldData: worldData,),
          ],
        ),
      ),
    );
  }
}
