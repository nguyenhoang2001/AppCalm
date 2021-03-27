import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app2/data/data.dart';
import 'package:flutter_app2/data//bubble_tab_indicator.dart';
import 'package:flutter_app2/Infor/MyCountry.dart';
import 'package:flutter_app2/Infor/Global.dart';
import 'package:flutter_app2/panels/most_affected_country.dart';

class page_1 extends StatefulWidget {
  @override
  _page_1 createState() => _page_1();
}

class _page_1 extends State<page_1> {
  int num = 0;
  Widget _My_Country = MyCountry1();
  Widget _Global = Global();

  List countryData;
  fetchCountryData() async {
    http.Response response =
    await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
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
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color(0xff40e0d0),
            expandedHeight: 120.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text("Statistics", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 27.0, color: Colors.white),),
            ),
          ),
          _buildHeader(screenHeight),
          _buildTips(screenHeight),
          _buildBody(screenHeight),
        ],
      ),
    );
  }
  SliverToBoxAdapter _buildHeader(double screenHeight) {

    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Color(0xff40e0d0), borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        )),
        child: Column(
          children: [
            DefaultTabController(
              length: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 60.0,
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(25.0)
                ),
                child: TabBar(
                  indicator: BubbleTabIndicator(
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                    indicatorHeight: 50.0,
                    indicatorColor: Color(0xff40e0d0),
                  ),
                  tabs: <Widget>[
                    Text("My Country", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
                    Text("Global", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
                  ],
                  onTap: (int tab_num){
                    this.Tab_handle(tab_num);
                  },
                ),
              ),
            ),
            GetInfor(),
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter _buildBody(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color(0xff40e0d0),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
            "Most affected countries",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
            //SizedBox(height: 2.0,),
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              ),
              ),
              child: Column(
                children:<Widget>[
                      countryData == null
                      ? CircularProgressIndicator()
                      : MostAffectedPanel(countryData: countryData,),]
              )
            ),
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter _buildTips(double screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Preventions",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28, color: Colors.black)),
            const SizedBox(height: 12.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: prevention.map((e) => Column(
                  children: <Widget>[
                    Container(
                      width: 127,
                      height: 130,
                      child: Image.asset(
                          e.keys.first,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0,),
                    Text(
                      e.values.first,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget GetInfor() {
    if (num == 0) {
      return this._My_Country;
    } else if (num == 1) {
      return this._Global;
    }
  }
  void Tab_handle(int Num){
    this.setState(() {
      this.num = Num;
    });
  }


}

