import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/net/flutterfire.dart';
import 'package:flutter_app2/ui/authentication.dart';
import 'package:flutter_app2/ui/profileView.dart';
import 'Home_page.dart';

class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _userNameField = TextEditingController();
  TextEditingController _dateofbirthField = TextEditingController();
  TextEditingController _phonenumberField = TextEditingController();
  TextEditingController _jobField = TextEditingController();

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
                height: MediaQuery.of(context).size.height/1.152,
                decoration: BoxDecoration(
                  border: Border.all(width: 7,
                    color: Colors.black.withOpacity(0.04),),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height /50),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width /2.8,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xffffffff),
                          ),
                          child : MaterialButton(
                            onPressed: () async {
                              //bool shouldNavigate = await signIn(_emailField.text,_passwordField.text);
                              //if(shouldNavigate){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Authentication(),
                              ),
                              );//navigate
                              //}
                            },
                            child: Text("Login"),
                            textColor: Color(0xff40e0d0),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.8,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xff40e0d0),
                          ),
                          child : MaterialButton(
                            onPressed: (){},
                            child: Text("Register"),
                            textColor: Colors.white,
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
                        controller: _userNameField,
                        decoration: InputDecoration(
                            hintText: "John Weak",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                            ),
                            labelText: "Your name",
                            labelStyle: TextStyle(color: Colors.black,)
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /80),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _dateofbirthField,
                        decoration: InputDecoration(
                            hintText: "31/01/2001",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                            ),
                            labelText: "Date of birth",
                            labelStyle: TextStyle(color: Colors.black,)
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /80),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _phonenumberField,
                        decoration: InputDecoration(
                            hintText: "098777777",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                            ),
                            labelText: "Phone number",
                            labelStyle: TextStyle(color: Colors.black,)
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /80),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _jobField,
                        decoration: InputDecoration(
                            hintText: "Doctor",
                            hintStyle: TextStyle(color: Colors.black.withOpacity(0.3),
                            ),
                            labelText: "Occupation",
                            labelStyle: TextStyle(color: Colors.black,)
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height /80),
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
                    SizedBox(height: MediaQuery.of(context).size.height /25),
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

                          bool shouldNavigate = await register(_emailField.text,_passwordField.text);
                          if(shouldNavigate == true){
                            myEmail(_emailField.text);
                            saveEmail(_emailField.text);
                            Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(),
                            ),
                            );//navigate
                            saveToFirebase(_emailField.text,_userNameField.text,_dateofbirthField.text,_phonenumberField.text,_jobField.text);
                          }},
                        child: Text("Register"),
                        textColor: Colors.white,
                      ),
                    ),
                    /*
      SizedBox(height: MediaQuery.of(context).size.height / 35),
      Text("Or"),
      SizedBox(height: MediaQuery.of(context).size.height /50),
      Expanded(child: GoogleSignInButton()),*/
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
