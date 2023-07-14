import 'package:flutter/material.dart';
import 'package:sound_of_ai/graphs.dart';
import 'package:sound_of_ai/welcome.dart';
import 'package:sound_of_ai/home.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get email => Auth().auth.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/white_1.png'),
                fit:BoxFit.cover)),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Auth.instance.logOut();
              print('Logout pressed');
            },
          ),
        ],
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHome()),
              );
            },
            child: Card(
                margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //Icon(Icons.file_upload),
                    //SizedBox(height: 10),
                    Image.asset(
                      'assets/head_phones2-removebg-preview.png',
                      width: 150,
                      height: 150,
                    ),
                    Text('UrbanSound Classifier'),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 70,),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWelcome()),
              );
            },
            child: Card(
                margin: EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //Icon(Icons.file_upload),
                    Image.asset(
                      'assets/heart_img-removebg-preview.png',
                      width: 150,
                      height: 150,
                    ),
                    //SizedBox(height: 10),
                    Text('HeartSound Classifier'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}