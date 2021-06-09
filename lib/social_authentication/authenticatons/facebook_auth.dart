import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginAuth{

  Future<FirebaseUser> signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken result = await FacebookAuth.instance.login(permissions:['email', 'public_profile'],loginBehavior:LoginBehavior.WEB_VIEW_ONLY);

    // Create a credential from the access token
    final AuthCredential facebookAuthCredential = FacebookAuthProvider.getCredential(accessToken: result.token);

    // Once signed in, return the UserCredential
    AuthResult authResult= await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    FirebaseUser user=authResult.user;
    return user;
  }

  Future signOut()async{
    await FacebookAuth.instance.logOut();
  }
}
