import 'package:flutter/material.dart';
import 'package:sound_of_ai/auth.dart';
class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  @override
  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController=TextEditingController();
  dynamic email_;
  dynamic password_;
  bool isPasswordVisible = false;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/white_1.png'),
              fit:BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
          body: Stack(
              children:[
                Container(
                  padding: EdgeInsets.only(left:35, top:40),
                  child:Text('Create\nAccount', style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                  )),
                ),
                SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3, right:35,left:35),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // margin: EdgeInsets.only(left: 35, right: 35),
                                  child: Column(
                                      children: [
                                        TextField(
                                          controller: emailController,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
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
                                              hintText:'Email',
                                              prefixIcon: Icon(Icons.email,color: Colors.black),
                                              border:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              )
                                          ),
                                          onChanged: (v){
                                            email_=v;
                                          },
                                        ),
                                        SizedBox(
                                          height:30,
                                        ),
                                        TextFormField(
                                          controller: passwordController,
                                          style: TextStyle(color: Colors.black),
                                          obscureText: !isPasswordVisible,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
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
                                                ),
                                              ),
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
                                              border:OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5)
                                              )
                                          ),
                                          onSaved: (v){
                                            password_=v;
                                          },
                                        ),
                                        SizedBox(
                                          height:40,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Sign Up', style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 27, fontWeight: FontWeight.w700
                                            )),
                                            GestureDetector(
                                                onTap: (){
                                                  Auth.instance.register_user(emailController.text.trim(), passwordController.text.trim());
                                                },
                                                child:
                                                CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor: Colors.black,
                                                    child: IconButton(
                                                      color:Colors.white,
                                                      onPressed:(){
                                                        Auth.instance.register_user(emailController.text.trim(), passwordController.text.trim());
                                                        print(email_);
                                                        print(password_);
                                                        print(emailController.text.trim());
                                                        print(passwordController.text.trim());
                                                      },
                                                      icon:Icon(Icons.arrow_forward),
                                                    )
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
                                              Navigator.pushNamed(context, 'login');
                                            }, child: Text('Sign In', style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontSize: 18,
                                                color: Colors.black
                                            ),)),
                                          ],
                                        )
                                      ]
                                  )
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