import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_authentication_app/social_authentication/pages/facebook_home_page.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/facebook_auth.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/facebook_authentication.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/google_authentication.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/twitter_authentication.dart';
import 'package:social_authentication_app/social_authentication/pages/google_home_page.dart';
import 'package:social_authentication_app/social_authentication/pages/twitter_home_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUser user;
  FirebaseUser faceUser;
  FirebaseUser twitterUser;
  dynamic profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text('Social Authentication'),),
      body:Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            GoogleSignInButton(
              onPressed:()async{
                user=await GoogleAuthentication().signInWithGoogle();
                if(user!=null){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomePage(user:user)));
                  Fluttertoast.showToast(
                      msg:'Logged In Successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
                else{
                  Fluttertoast.showToast(
                      msg:'User Not Found',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
                // GoogleSignInProvider().signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>HomePage())));
              },
            ),
            SizedBox(height:20,),
            FacebookSignInButton(
              onPressed: ()async{
                faceUser=await FacebookLoginAuth().signInWithFacebook();
                if(await faceUser!=null){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>FacebookHomePage(faceUser:faceUser,)));
                  Fluttertoast.showToast(
                      msg:'Logged In Successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
                else{
                  Fluttertoast.showToast(
                      msg:'User Not Found',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
              },
              centered:true,
            ),
            SizedBox(height:20,),
            TwitterSignInButton(
              onPressed:()async{
                twitterUser=await TwitterAuthentication().signInWithTwitter();
                if(await twitterUser!=null){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>TwitterHomePage(user:twitterUser,)));
                  Fluttertoast.showToast(
                      msg:'Logged In Successfully',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
                else{
                  Fluttertoast.showToast(
                      msg:'User Not Found',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
