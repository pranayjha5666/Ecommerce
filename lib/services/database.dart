import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce2/pages/wallet.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .set(userInfoMap);
  }

  UpdateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .update({"Wallet": amount});
  }



  Future addFoodItems(Map<String, dynamic> userInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getFoodItems(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future addFoodToCart(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('user')
        .doc(id)
        .collection("Carts")
        .add(userInfoMap);
  }


  Future<Stream<QuerySnapshot>> getFoodCart(String id) async {
    return await FirebaseFirestore.instance.collection("user").doc(id).collection("Carts").snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserWallet(String id) async {
    return await FirebaseFirestore.instance.collection("user").snapshots();
  }



}
