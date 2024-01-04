import 'package:ecommerce2/services/sharedpreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class AuthMethods{
  final FirebaseAuth auth=FirebaseAuth.instance;

  getCurrentUser() async{
    return await auth.currentUser;
  }


  Future SignOut() async{
    await FirebaseAuth.instance.signOut();
    await SharedPreferencesHelper().clearUserData();

  }

  Future Deleteuser() async{
    User? user=await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}