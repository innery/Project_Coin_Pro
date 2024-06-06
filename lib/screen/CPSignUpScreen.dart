import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:coinpro_prokit/utils/CPWidgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:coinpro_prokit/screen/CPLoginScreen.dart';
import 'package:coinpro_prokit/utils/CPColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class CPSignUpScreen extends StatefulWidget {
  @override
  CPSignUpScreenState createState() => CPSignUpScreenState();
}

class CPSignUpScreenState extends State<CPSignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passWordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password); // Convert the password to a list of bytes
    final digest = sha256.convert(bytes); // Compute the SHA-256 hash
    return digest.toString(); // Convert the hash to a string
  }

   String generateRandomNumber(int length) {
    final random = Random();
    String number = '';
    for (int i = 0; i < length; i++) {
      number += random.nextInt(10).toString();
    }
    return number;
  }

  Future<void> signUp(BuildContext context) async {
    final email = emailController.text;
    final password = passController.text;
    final hashedPassword = hashPassword(password);
    final userName = userNameController.text;
    final contactNumber = generateRandomNumber(10);

    


      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password, // Supabase'e orijinal şifreyi gönderiyoruz, çünkü Supabase kendi şifreleme yöntemini kullanır.
        data: {'displayName': userName},
      );
      final error = response;
      if (error == null) {
        return;
      }
      else {
      }

      final insertResponse = await Supabase.instance.client.from('profileusers').insert({
              // Supabase tarafından oluşturulan kullanıcı ID'si
              'username': userNameController.text,
              'email': emailController.text,
              'password': hashedPassword,
              'contactnumber': contactNumber, // Hashlenmiş şifreyi kaydediyoruz
            }); 

        if (insertResponse != null) {
          
        } else {
          setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CPLoginScreen()));
          });
        } 
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?  ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: CPPrimaryColor,
                ),
              ).onTap(
                () {
                  finish(context);
                },
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 80, bottom: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Register new \naccount",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 3,
                        decoration: boxDecorations(radius: 8, bgColor: CPPrimaryColor, showShadow: false),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: userNameController,
                    obscureText: false,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                    focusNode: userNameFocus,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      hintText: "UserName",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      filled: true,
                      isDense: false,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 12, 8),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: emailController,
                    obscureText: false,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(passWordFocus);
                    },
                    focusNode: emailFocus,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      filled: true,
                      isDense: false,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 12, 8),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    focusNode: passWordFocus,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      filled: true,
                      isDense: false,
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined, color: Color(0xffa7a7a7), size: 22),
                    ),
                  ),
                  SizedBox(height: 32),
                  MaterialButton(
                    onPressed: () {
                      signUp(context);
                    },
                    color: Color(0xff2972ff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      "SignUp",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.normal),
                    ),
                    textColor: Color(0xffffffff),
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
