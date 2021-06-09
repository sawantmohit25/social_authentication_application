import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart'as http;

class FacebookAuthentication{
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithFacebook() async {
    facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;
    // if you remove above comment then facebook login will take username and pasword for login in Webview
    try {
      final FacebookLoginResult facebookLoginResult = await facebookSignIn.logIn(['email', 'public_profile']);
      if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken = facebookLoginResult.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: facebookAccessToken.token);
        AuthResult result= await auth.signInWithCredential(credential);
        final FirebaseUser user = result.user;
        print(user);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> facebookLoginout() async {
    await auth.signOut();
    await facebookSignIn.logOut();
    return true;
  }


  // Future<dynamic> signInWithFacebook()async{
  //   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
  //
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       final token = result.accessToken.token;
  //       print('mohit${token}');
  //       final graphResponse = await http.get(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
  //       final profile =jsonDecode(graphResponse.body);
  //       print('''
  //        Logged in!
  //
  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //       return profile;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print('Login cancelled by the user.');
  //       return null;
  //     case FacebookLoginStatus.error:
  //       print('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       return null;
  //   }
  //
  // }

  // Future<bool> logOut() async {
  //   await facebookSignIn.logOut();
  //   print('Logged out.');
  //   return true;
  // }

}