import 'package:flutter/material.dart';
import 'package:flutter_app2/net/flutterfire.dart';
import 'package:flutter_app2/ui/profileView.dart';
import 'package:flutter_app2/ui/registerView.dart';
import 'Home_page.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> with TickerProviderStateMixin{
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/hoang.png'),
            alignment: Alignment.topCenter,
          ),
        ),
        alignment: Alignment(0,0.05),
        child:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width/1.2,
                height: MediaQuery.of(context).size.height/1.65,
                decoration: BoxDecoration(
                  border: Border.all(width: 7,
                    color: Colors.black.withOpacity(0.04),),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width /2.8,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xff40e0d0),
                          ),
                          child : MaterialButton(
                            onPressed: (){},
                            child: Text("Login"),
                            textColor: Colors.white,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.8,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          ),
                          child : MaterialButton(
                            onPressed: () async {
                              //bool shouldNavigate = await register(_emailField.text,_passwordField.text);
                              //if(shouldNavigate){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterView(),
                              ),
                              );//navigate
                            },
                            child: Text("Register"),
                            textColor: Color(0xff40e0d0),
                          ),
                        ),//register
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _emailField,
                        decoration: InputDecoration(
                            hintText: "something@email.com",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(color: Colors.black,)
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /80),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _passwordField,
                        decoration: InputDecoration(
                          hintText: "1234567",
                          hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black,),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      width: MediaQuery.of(context).size.width /1.5,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xff40e0d0),
                      ),
                      child : MaterialButton(
                        onPressed: () async {
                          bool shouldNavigate = await signin(_emailField.text,_passwordField.text);
                          print("it come here");
                          //await signin(_emailField.text,_passwordField.text).whenComplete(() => Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(),)
                          if(shouldNavigate != false){
                            await myEmail(_emailField.text);
                            saveEmail(_emailField.text);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(),
                            ),
                            );//navigate
                          }},
                        child: Text("Login"),
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}