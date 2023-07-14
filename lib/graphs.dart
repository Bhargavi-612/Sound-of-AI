import 'package:flutter/material.dart';
import 'package:sound_of_ai/auth.dart';
import "dart:io";
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class MyGraphs extends StatefulWidget {
  const MyGraphs({Key? key}) : super(key: key);

  @override
  State<MyGraphs> createState() => _MyGraphsState();
}

class _MyGraphsState extends State<MyGraphs> {

  Future<http.Response> fetchImage() {
    //return http.get(Uri.parse('http://10.0.2.2:5000/plot'));
    return http.get(Uri.parse('http://16.171.133.237/plot'));
    //return http.get(Uri.parse('http://13.49.238.235/plot'));
  }

  Future<http.Response> fetchSpect() {
    //return http.get(Uri.parse('http://10.0.2.2:5000/spect'));
    return http.get(Uri.parse('http://16.171.133.237/spect'));
    //return http.get(Uri.parse('http://13.49.238.235/spect'));
  }

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
              title: Text('Graphs'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),// Empty widget to reserve space for the title
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    // Perform logout action
                    Auth.instance.logOut();
                    print('Logout pressed');
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Center(
                    child:Text('Time-Amplitude Graph', style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.2, // Set a fixed height
                      child: Scaffold(
                        body: Center(
                          child: FutureBuilder<http.Response>(
                            future: fetchImage(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done &&
                                  snapshot.hasData &&
                                  snapshot.data!.statusCode == 200) {
                                return Image.memory(snapshot.data!.bodyBytes);
                              } else if (snapshot.hasError) {
                                return Text('Failed to load image');
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      )
                  ) ,
                  SizedBox(height: 40,),
                  Center(
                    child:Text('Spectrogram', style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                  ),
                  Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height * 0.3, // Set a fixed height
                      child: Scaffold(
                        body: Center(
                          child: FutureBuilder<http.Response>(
                            future: fetchSpect(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done &&
                                  snapshot.hasData &&
                                  snapshot.data!.statusCode == 200) {
                                return Image.memory(snapshot.data!.bodyBytes);
                              } else if (snapshot.hasError) {
                                return Text('Failed to load image');
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                      )


                  )

                ],
              ),
            )
        )
    );
  }
}
