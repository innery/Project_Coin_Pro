import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:coinpro_prokit/screen/CPDashBoardScreen.dart';
import 'package:coinpro_prokit/screen/CPSignUpScreen.dart';
import 'package:coinpro_prokit/utils/CPColors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CPLoginScreen extends StatefulWidget {
  @override
  CPLoginScreenState createState() => CPLoginScreenState();
}

class CPLoginScreenState extends State<CPLoginScreen> {
  bool? checkBoxValue = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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

  Future<void> signIn() async {
    final response = await Supabase.instance.client.auth.signInWithPassword(
      email: emailController.text,
      password: passController.text,
    );

     if (response.session == null) {
      // Oturum açma başarısızsa hata mesajını göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarısız. Lütfen bilgilerinizi kontrol edin ve tekrar deneyin.')),
      );
    } else {
      // Başarılı giriş sonrası kullanıcıyı ana sayfaya yönlendir
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Giriş başarılı!')),
      );
      CPDashBoardScreen().launch(context);
    }
  }

 
Future<AuthResponse> _googleSignIn() async {

    const clientId = "677828531793-hsnskqr8hbipveakjjc87j4klhk792t5.apps.googleusercontent.com";

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: clientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'No Access Token found.';
  }
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  final response = await Supabase.instance.client.auth.signInWithIdToken(
    provider: OAuthProvider.google,
    idToken: idToken!,
    accessToken: accessToken!,
  );

  return response;
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
                "Don't have an account?  ",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: CPPrimaryColor,
                ),
              ).onTap(
                () {
                  CPSignUpScreen().launch(context);
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
                    "Login to your \naccount",
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
                      Container(width: 60, height: 3, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CPPrimaryColor, boxShadow: defaultBoxShadow())),
                      SizedBox(width: 8),
                      Container(width: 10, height: 3, decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: CPPrimaryColor, boxShadow: defaultBoxShadow())),
                    ],
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
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.transparent, width: 0)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.transparent, width: 0)),
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
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.transparent, width: 1)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.transparent, width: 1)),
                      suffixIcon: Icon(Icons.remove_red_eye_outlined, color: Color(0xffa7a7a7), size: 22),
                    ),
                  ),
                  SizedBox(height: 16),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Remember Me", style: primaryTextStyle()),
                    value: checkBoxValue,
                    dense: true,
                    onChanged: (newValue) {
                      setState(() {
                        checkBoxValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  SizedBox(height: 16),
                  MaterialButton(
                    onPressed: signIn, // Giriş işlemi için signIn fonksiyonunu çağır
                    color: Color(0xff2972ff),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.normal),
                    ),
                    textColor: Color(0xffffffff),
                    height: 40,
                    minWidth: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: Text(
                      "OR",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff9d9d9d),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  MaterialButton(
  onPressed: () {
    _googleSignIn().then((response) {
      if (response.session != null) {
        // Başarılı giriş sonrası kullanıcıyı ana sayfaya yönlendir
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş başarılı!')),
        );
        CPDashBoardScreen().launch(context);
      } else {
        // Giriş başarısızsa hata mesajını göster
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google ile giriş başarısız. Lütfen tekrar deneyin.')),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bir hata oluştu: $error')),
      );
    });
  },
  color: context.cardColor,
  elevation: 0,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  child: Text(
    "Login with Google",
    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontStyle: FontStyle.normal),
  ),
  height: 40,
  minWidth: MediaQuery.of(context).size.width,
),             
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
