
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
 ConfirmationResult confirmationResult;
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final auth = FirebaseAuth.instance;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey = GlobalKey<FormState>();
  var passwordkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String phone;
  String otp;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('APC COLLEGE VOTING'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/apc.jpg",
                width: size.width,
                height: size.height,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Powered By Digisailor',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFFFDF5E6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        Form(
                          key: formkey,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.length < 5)
                                  return " Enter at least 8 character from your email";
                                else
                                  return null;
                              },
                              controller: nameController,
                              onChanged: (value) {
                                phone = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32),
                                    ),
                                  ),
                                  hintText: "Phone",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF87837e),
                                  ),
                                  suffixIcon: Icon(Icons.phone_in_talk),
                                  filled: true,
                                  focusColor: Colors.yellow),
                              style: GoogleFonts.lato(color: Colors.black),
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async{
                            print(phone);
                            FirebaseAuth auth = FirebaseAuth.instance;
                            confirmationResult =
                                await auth.signInWithPhoneNumber(phone,
                                    RecaptchaVerifier(
                                      container: 'recaptcha',
                                      size: RecaptchaVerifierSize.compact,
                                      theme: RecaptchaVerifierTheme.dark,
                                    )
                                );
                          },
                          child: Text(
                            'Generate OTP',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: passwordkey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 90),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.length < 5)
                                  return " Enter at least 8 character from your email";
                                else
                                  return null;
                              },
                              controller: passwordController,
                              onChanged: (value) {
                                otp = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(32),
                                    ),
                                  ),
                                  hintText: "OTP",
                                  hintStyle: TextStyle(
                                    color: Color(0xFF87837e),
                                  ),
                                  suffixIcon: Icon(Icons.confirmation_num),
                                  filled: true,
                                  focusColor: Colors.yellow),
                              style: GoogleFonts.lato(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Material(
                          elevation: 5.0,
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () async{
                              UserCredential userCredential =
                              await confirmationResult.confirm(otp).then((value){

                                if (value.user.metadata.creationTime ==
                                    value.user.metadata.lastSignInTime) {print('User Does not Exit');
                                } else {
                                  print('User Exists');
                                }
                                return;
                              });
                          },
                            child: Text(
                              'LOGIN',
                              style: TextStyle(color: Colors.white),
                            ),
                            minWidth: 100,
                            height: 42.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 300,
                  width: 500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
