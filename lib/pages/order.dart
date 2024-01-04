import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce2/services/database.dart';
import 'package:ecommerce2/services/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {

  Stream? foodStream;
  String? id,wallet;
  int finaltotal=0,finalwalletamountdeducted=0;



  void setTimer(){
      Timer(Duration(seconds: 2), () {
        finalwalletamountdeducted=finaltotal;
        setState(() {

        });
      });
  }


  getthesharedpref() async{
    id=await SharedPreferencesHelper().getUserId();
    wallet=await SharedPreferencesHelper().getUserWallet();
    setState(() {
    });
  }

  ontheLoad()async{
    await getthesharedpref();
    foodStream=await DatabaseMethods().getFoodCart(id!);
    setState(() {
    });
  }

  @override
  void initState() {
    ontheLoad();
    setTimer();
    // TODO: implement initState
    super.initState();
  }


  Widget FoodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds=snapshot.data.docs[index];
                finaltotal=finaltotal+int.parse(ds["Total"]);
                return Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 40,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(child: Text(ds["Quantity"])),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              ds["Image"],
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                ds["Name"],
                                style: AppWidget.SemiBoldTextFieldStyle(),
                              ),
                              Text(
                                "\$"+ds["Total"],
                                style: AppWidget.SemiBoldTextFieldStyle(),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );

              })
              : Center(child: CircularProgressIndicator());
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                    child: Text(
                  "Food Cart",
                  style: AppWidget.headlineTextFieldStyle(),
                )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height/2,
                child: FoodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "\$"+finaltotal.toString(),
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async{
                int amount=int.parse(wallet!)-finalwalletamountdeducted;
                await DatabaseMethods().UpdateUserWallet(id!, amount.toString());
                await SharedPreferencesHelper().saveUserWalletKey(amount.toString());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(left: 20.0, right: 20.0,bottom: 20),
                child: Center(
                  child: Text(
                    "CheckOut",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
