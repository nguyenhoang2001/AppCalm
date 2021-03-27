import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/commons/const.dart';
import 'package:flutter_app2/commons/utils.dart';
import 'package:flutter_app2/controllers/FBCloudMessaging.dart';
import 'package:flutter_app2/threadworking/threadMain.dart';
import 'package:flutter_app2/ui/profileView.dart';
import 'package:flutter_app2/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_1.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}
String emailtopost;
Future <void >myEmail(String email) async {
  emailtopost = email;
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  TabController _tabController;
  MyProfileData myData;
  bool _isLoading = false;
  static String realName;

  @override
  void initState() {
    FBCloudMessaging.instance.takeFCMTokenWhenAppLaunch();
    FBCloudMessaging.instance.initLocalNotification();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
    setupMyName();
    super.initState();
  }

   Future<void>setupMyName() async{
    CollectionReference collectionReference = Firestore.instance.collection('Users').document(emailtopost).collection('Profile');
    collectionReference.snapshots().listen((snapshot) {
      print(snapshot.documents[0]['Name'].toString());
      realName = snapshot.documents[0].data['Name'];
      _takeMyData();
    });
  }

  Future<void> _takeMyData() async{
    setState((){
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myThumbnail;
    String myName;
    if (prefs.get('myThumbnail') == null) {
      String tempThumbnail = 'user.png';
      prefs.setString('myThumbnail',tempThumbnail);
      myThumbnail = tempThumbnail;
    }else{
      myThumbnail = 'user.png';
    }
    if (prefs.get('myName') == null){
      String tempName = realName;
      prefs.setString('myName',tempName);
      myName = tempName;
    }else{
      myName = prefs.get('myName');}

    if(myName != realName){
      String tempName = realName;
      prefs.setString('myName',tempName);
      myName = tempName;
    }
    setState(() {
      myData = MyProfileData(
        myThumbnail: myThumbnail,
        myName: myName,
        myLikeList: prefs.getStringList('likeList'),
        myLikeCommnetList: prefs.getStringList('likeCommnetList'),
        myFCMToken: prefs.getString('FCMToken'),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
  void _handleTabSelection() => setState(() {});
  void onTabTapped(int index) {
    setState(() {
      _tabController.index = index;
    });
  }
  void updateMyData(MyProfileData newMyData) {
    setState(() {
      myData = newMyData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
              controller: _tabController,
              children: [
                page_1(),
                Home(),
                ThreadMain(myData: myData,updateMyData: updateMyData,),
                ProfileView(),
              ]
          ),
          Utils.loadingCircle(_isLoading),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _tabController.index,
        selectedItemColor: Color(0xff40e0d0),
        unselectedItemColor: Colors.grey[800],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.coronavirus_rounded),
            title: Text('NCOVID-19'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot_rounded),
            title: new Text('Top News'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.people),
            title: new Text('Thread'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('Profile'),
          ),
        ],
      ),
    );
  }
}