import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/theme/colors/light_colors.dart';
import 'package:flutter_app2/widgets/task_column.dart';
import 'package:flutter_app2/widgets/top_container.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

String uid;
void saveEmail(String email){
  uid = email;
}

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
        StreamBuilder(
            stream: Firestore.instance
                .collection('Users').document(uid).collection('Profile').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: snapshot.data.documents.map((document){
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height/1.25,
                      child: Column(
                        children: [
                    TopContainer(
                      height: 230,
                      width: width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: <Widget>[
                                Icon(Icons.menu,
                                    color: LightColors.kDarkBlue, // just change to test
                                    size: 30.0),
                              ],
                            ),*/
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 0.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CircularPercentIndicator(
                                    radius: 90.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.75,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Colors.yellow,
                                    backgroundColor: Color(0xff40e0d0), // just change to test
                                    center: CircleAvatar(
                                      backgroundColor: Colors.pink[200],
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                        'images/avatar.png',
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                            '${document['Name']}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: LightColors.kDarkBlue,
                                              fontWeight: FontWeight.w800,
                                              fontSize: 25.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '${document['Job']}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 40.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      subheading('User Profile'),
                                    ],
                                  ),
                                  SizedBox(height: 40.0),
                                  TaskColumn(
                                    icon: Icons.email,
                                    iconBackgroundColor: LightColors.kRed,
                                    title: 'Email',
                                    subtitle: '${document['Email']}',
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                  TaskColumn(
                                    icon: Icons.calendar_today,
                                    iconBackgroundColor: LightColors
                                        .kDarkYellow,
                                    title: 'Date of Birth',
                                    subtitle: '${document['Date of birth']}',
                                  ),
                                  SizedBox(height: 40.0),
                                  TaskColumn(
                                    icon: Icons.phone,
                                    iconBackgroundColor: LightColors.kBlue,
                                    title: 'Phone Number',
                                    subtitle: '${document['Phone number']}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    ]
                    )
                    );
                  }).toList(),
                ),
                ),
              );
            }
        ),

    );
  }
}
