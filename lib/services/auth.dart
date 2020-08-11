import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final db = Firestore.instance;

Future<String> handleSignInEmail(String email, String password) async {
  try {
    AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);

    return db.collection('account').document(user.uid).collection('type').toString();
  } catch (e) {
    print(e);
  }
}

Future<FirebaseUser> handleSignUp(email, password, type) async {
  try{
    AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    await db.collection('account').document(user.uid).setData({'type': type});

    return user;
  } catch (e) {
    print(e);
  }
}
