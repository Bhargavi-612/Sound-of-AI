import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sound_of_ai/auth.dart';
class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();
  dynamic e;
  dynamic p;
  bool isPasswordVisible = false;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/white_1.png'),
              fit:BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
              children:[
                Container(
                  padding: EdgeInsets.only(left:35, top:130),
                  child:Text('Sound of AI', style: TextStyle(
                    // color: Color(0xff003c5f),
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  )),
                ),
                Container(
                  padding: EdgeInsets.only(left:35, top:200),
                  child:Text('Sound Classifier', style: TextStyle(
                    //color: Color(0xff003c5f),
                    color: Colors.black,
                    fontSize: 25,
                  )),
                ),
                SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4, right:35,left:35),
                        child: Column(
                            children: [
                              TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintText:'Email',
                                    prefixIcon: Icon(Icons.email, color: Colors.black),
                                    enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          //width: 2
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2
                                      ),
                                    ),
                                ),
                                onChanged: (v){
                                  e=v;
                                },
                              ),
                              SizedBox(
                                height:30,
                              ),
                              TextField(
                                controller: passwordController,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintText:'Password',
                                    prefixIcon: Icon(Icons.password, color: Colors.black),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordVisible = !isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                  ),
                                    enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                        color: Colors.black,
                                        //width: 2
                                    ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2
                                      ),
                                    ),
                                ),
                                onChanged: (v1){
                                  p=v1;
                                },
                              ),
                              SizedBox(
                                height:40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sign In', style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 27, fontWeight: FontWeight.w700
                                  )),
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black,
                                      child: IconButton(
                                        color:Colors.white,
                                        onPressed:(){
                                          Auth.instance.login_user(emailController.text.trim(), passwordController.text.trim());
                                          print(emailController.text.trim());
                                          print(passwordController.text.trim());
                                        },
                                        icon:Icon(Icons.arrow_forward),
                                      )
                                  )
                                ],
                              ),
                              SizedBox(
                                  height:40
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(onPressed: (){
                                    Navigator.pushNamed(context, 'register');
                                  }, child: Text('Sign Up', style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18,
                                      color: Colors.black
                                  ),)),
                                  TextButton(onPressed: (){
                                    Navigator.pushNamed(context, 'phone');
                                  }, child: Text('Login with phone no.', style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 18,
                                      color: Colors.black
                                  ),))
                                ],
                              )
                            ]
                        )
                    )
                )
              ]
          )
      ),
    );
  }
}