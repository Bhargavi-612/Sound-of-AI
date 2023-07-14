import 'package:flutter/material.dart';
import 'package:sound_of_ai/auth.dart';
import "dart:io";
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyWelcome extends StatefulWidget {
  const MyWelcome({Key? key}) : super(key: key);
  @override
  State<MyWelcome> createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> {
  String? _filePath;
  String? _filePath1;
  String? predicted;
  String prediction='';
  int flag=0;
  int flag1=0;
  int flag2=0;
  int flag3=0;
  int flag4=0;
  File graph=File('');
  String imageUrl = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final audioPlayer = AudioPlayer();
  final audioPlayer1 = AudioPlayer();
  bool isPlaying=false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying1=false;
  Duration duration1 = Duration.zero;
  Duration position1 = Duration.zero;

  @override
  void initState(){
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState((){
        isPlaying= state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration){
      setState(() {
        duration=newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer1.onPlayerStateChanged.listen((state1) {
      setState((){
        isPlaying1= state1 == PlayerState.playing;
      });
    });
    audioPlayer1.onDurationChanged.listen((newDuration1){
      setState(() {
        duration1=newDuration1;
      });
    });
    audioPlayer1.onPositionChanged.listen((newPosition1) {
      setState(() {
        position1 = newPosition1;
      });
    });
  }

  @override
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> uploadAudio(File audioFile) async {
    var request = http.MultipartRequest(
      //'POST', Uri.parse('http://10.0.2.2:5000/predict'));
        'POST', Uri.parse('http://16.171.133.237/predict'));
    //'POST', Uri.parse('http://13.49.238.235/predict'));
    request.files.add(
      await http.MultipartFile.fromPath(
        'audio',
        audioFile.path,
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    setState(() {
      prediction = responseData;
    });
    debugPrint(responseData);
    await addPredictionToFirestore(responseData);
  }

  Future<void> addPredictionToFirestore(String prediction) async {
    final User? user = _auth.currentUser;
    final String userId = user?.uid ?? '';

    try {
      await _firestore.collection('predictions').add({
        'userId': userId,
        'prediction': prediction,
        'timestamp': DateTime.now(),
      });
      print('Prediction added to Firestore successfully');
    } catch (e) {
      print('Error adding prediction to Firestore: $e');
    }
  }

  Future<void> pickFile() async{
    FilePickerResult? result=await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if(result!=null){
      PlatformFile file=result.files.first;
      setState(() {
        _filePath=file.path;
        flag1=1;
      });
      // _fileName=result!.files.first.name;
      // pickedfile=result!.files.first;
      //fileToDisplay=File(pickedfile!.path.toString() as List<Object>);
      //print('File name $_fileName');
    }
  }

  Future<void> uploadAudio1(File audioFile) async {
    var request = http.MultipartRequest(
      //  'POST', Uri.parse('http://10.0.2.2:5000/graphs'));
        'POST', Uri.parse('http://16.171.133.237/graphs'));
    //'POST', Uri.parse('http://13.49.238.235/graphs'));
    request.files.add(
      await http.MultipartFile.fromPath(
        'audio',
        audioFile.path,
      ),
    );
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                ),
              ),
              title: Text('Heart Sound Classifier',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,)), // Empty widget to reserve space for the title
              actions: [
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.black,),
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
                  ElevatedButton.icon(
                      icon: Icon(Icons.headset),
                      label: Text('Upload Audio'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ), onPressed:
                  pickFile
                  ),
                  SizedBox(height: 50,),
                  flag3==1?
                  Center(
                    child: CircularProgressIndicator(),
                  ):
                  _filePath != null
                      ? Text(
                      'Selected file: $_filePath')
                      : Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.file_upload_off, size: 50,weight: 4,),
                          SizedBox(height: 20),
                          Text('No file selected'),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 30,),
                  flag1==1?Column(
                    children: [
                      Slider(
                        min:0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async{
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);
                          await audioPlayer.resume();
                        },
                        activeColor: Colors.black, // Color for active part of the Slider
                        inactiveColor: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatTime(position)),
                            Text(formatTime(duration)),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.black,
                        child: IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause: Icons.play_arrow,
                            color: Colors.white,
                          ),
                          iconSize: 50,
                          onPressed: () async{
                            if(isPlaying){
                              await audioPlayer.pause();
                            }
                            else{
                              File audioFile = File(_filePath??"");
                              await audioPlayer.play(UrlSource(audioFile.path));
                            }
                          },
                        ),
                      ),
                    ],
                  ):Text(""),
                  SizedBox(height: 50,),
                  ElevatedButton.icon(onPressed: ()async{
                    setState(() {
                      flag2=1;
                    });
                    await uploadAudio(File(_filePath??""));
                    setState(() {
                      flag2=0;
                      flag4=1;
                    });
                  },
                    icon: Icon(Icons.graphic_eq),
                    label: Text('Predict'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  flag2==1?
                  Center(
                    child: CircularProgressIndicator(),
                  ):
                  //Text(""),
                  prediction!=''?
                  Center(
                    child:Text('$prediction', style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    )),
                  ):Text(''),
                  SizedBox(height: 20,),
                  flag4==1?Column(
                      children:[
                        Slider(
                          min:0,
                          max: duration1.inSeconds.toDouble(),
                          value: position1.inSeconds.toDouble(),
                          onChanged: (value) async{
                            final position1 = Duration(seconds: value.toInt());
                            await audioPlayer1.seek(position1);
                            await audioPlayer1.resume();
                          },
                          activeColor: Colors.black, // Color for active part of the Slider
                          inactiveColor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(position1)),
                              Text(formatTime(duration1)),
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(
                              isPlaying1 ? Icons.pause: Icons.play_arrow,
                              color: Colors.white,
                            ),
                            iconSize: 50,
                            onPressed: () async{
                              if(isPlaying1){
                                await audioPlayer1.pause();
                              }
                              else{
                                // Calculate the new ending index
                                int endIndex = prediction.length - 5;

                                // Extract a portion of the string from index 7 to endIndex
                                String sliced = prediction.substring(0, endIndex);
                                await audioPlayer1.play(AssetSource('${sliced}.wav'));
                              }
                            },
                          ),
                        ),
                      ]
                  ):Text(""),
                  Text(""),
                  SizedBox(height: 20,),
                  ElevatedButton.icon(onPressed: ()async{
                    setState(() {
                      flag=1;
                    });
                    await uploadAudio1(File(_filePath??""));
                    setState(() {
                      flag=0;
                    });
                    Navigator.pushNamed(context, 'graphs');
                  },
                    icon: Icon(Icons.show_chart),
                    label: Text('Visualization'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                  flag==1?
                  Center(
                    child: CircularProgressIndicator(),
                  ):
                  Text("")

                ],
              ),
            )
        )
    );
  }
}