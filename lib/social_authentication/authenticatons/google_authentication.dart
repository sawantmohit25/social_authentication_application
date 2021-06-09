import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  FirebaseAuth auth=FirebaseAuth.instance;
  final googleSignIn=GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle()async{
    try{
      GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();

      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;

        AuthCredential authCredential=GoogleAuthProvider.getCredential(idToken:googleSignInAuthentication.idToken, accessToken:googleSignInAuthentication.accessToken);

        AuthResult result= await auth.signInWithCredential(authCredential);

        FirebaseUser user=result.user;
        print(user.displayName);
        return user;
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signOutWithGoogle()async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
  }