import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
class TwitterAuthentication{

  // Create a TwitterLogin instance
  final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: 'kALD2qzGroF057J7r27UzU79p',
    consumerSecret:'1m4A6C3gXAVWSv2VPjuaQLEOU7PxvTbzJWGvwNWbUsWdGCnrMA',
  );

  Future<FirebaseUser> signInWithTwitter() async {

    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;
    // Create a credential from the access token
    final AuthCredential twitterAuthCredential = TwitterAuthProvider.getCredential(
      authToken: twitterSession.token,
      authTokenSecret: twitterSession.secret,
    );

     AuthResult authResult=await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
     FirebaseUser user=authResult.user;
     return user;
  }
  Future signOut()async{
    await twitterLogin.logOut();
  }
}