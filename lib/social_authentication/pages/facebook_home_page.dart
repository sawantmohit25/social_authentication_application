import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/facebook_auth.dart';
import 'package:social_authentication_app/social_authentication/authenticatons/facebook_authentication.dart';
import 'package:social_authentication_app/social_authentication/pages/login_page.dart';
class FacebookHomePage extends StatelessWidget {
  FirebaseUser faceUser;
  FacebookHomePage({@required this.faceUser});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('Home Page'),
        actions: [
          FlatButton.icon(onPressed:()async{
            await FacebookLoginAuth().signOut();
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>LoginPage()));
            Fluttertoast.showToast(
                msg:'Logged Out Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.blue,
                textColor: Colors.white
            );
          }, icon:Icon(Icons.logout,color:Colors.white,), label:Text('Logout',style:TextStyle(color:Colors.white),))
        ],
      ),
      body:Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text('USER DETAILS',style:TextStyle(fontSize:40,fontWeight:FontWeight.bold),),
            SizedBox(height:20),
            Container(
              width: 133.0,
              height:133.0,
              decoration:BoxDecoration(image:DecorationImage(image:NetworkImage(faceUser.photoUrl),fit:BoxFit.fill),shape: BoxShape.circle,color: Colors.blue,),
            ),
            SizedBox(height:20),
            Text(faceUser.displayName!=null?faceUser.displayName:'',style:TextStyle(fontSize:30),),
            SizedBox(height:20),
            Text(faceUser.phoneNumber!=null?faceUser.phoneNumber:'',style:TextStyle(fontSize:30),)
          ],
        ),
      ),
    );
  }
}
