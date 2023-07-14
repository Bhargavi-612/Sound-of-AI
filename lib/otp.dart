import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:sound_of_ai/phone.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code="";
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/white_1.png'),
                fit:BoxFit.cover)),
    child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
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
        ),
        body: Container(
            margin: EdgeInsets.only(left: 25,right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/sign.png',
                      width: 170,
                      height: 170,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Phone Verification',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'We need to register your phone before getting started !',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Pinput(
                    //   length: 6,
                    //   showCursor: true,
                    //   onChanged: (value){
                    //     code=value;
                    //   },
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black), // Color of the border
                        borderRadius: BorderRadius.circular(8.0), // Border radius of the container
                      ),
                      child: Pinput(
                        length: 6,
                        showCursor: true,
                        onChanged: (value) {
                          code = value;
                        },
                        defaultPinTheme: defaultPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        focusedPinTheme: focusedPinTheme,// Color of the input text
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()async{
                            try{
                              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                              // Sign the user in (or link) with the credential
                              await auth.signInWithCredential(credential);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'page', (route) => false);
                            }
                            catch(e){
                              Get.snackbar('About OTP', 'OTP message',
                                  backgroundColor: Colors.black,
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: Text(
                                    'Wrong OTP',
                                    style: TextStyle(
                                        color:Colors.white
                                    ),
                                  ),
                                  messageText: Text(
                                    e.toString(),
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              );
                            }
                          },
                          child: Text(
                              'Verify phone number'
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              )
                          ),
                        )
                    ),
                    Row(
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'phone',
                                      (route) => false
                              );
                            },
                            child: Text(
                              'Edit phone number ?',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                        )
                      ],
                    )
                  ],
                )
            )
        )
    )
    );
  }
}