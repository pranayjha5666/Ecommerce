import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce2/pages/details.dart';
import 'package:ecommerce2/services/database.dart';
import 'package:ecommerce2/services/sharedpreferences.dart';
import 'package:ecommerce2/widget/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, pizza = false, burger = false, salad = false;

  Stream? fooditemStream,fooditemStream1;

  ontheLoad() async {
    fooditemStream = await DatabaseMethods().getFoodItems("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheLoad();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
             padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
              DocumentSnapshot ds=snapshot.data.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],image: ds["Image"],price: ds["Price"])));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 20.0, right: 5, top: 5, bottom: 5),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              ds["Image"],
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          ),
                          Text( ds["Name"],
                            style: AppWidget.SemiBoldTextFieldStyle(),
                          ),
                          Text("Honey goot cheese",
                              style: AppWidget.LightTextFieldStyle()),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$"+ds["Price"],
                            style: AppWidget.SemiBoldTextFieldStyle(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );

          })
              : CircularProgressIndicator();
        });
  }
  Widget allItemsVertically() {
    return StreamBuilder(
        stream: fooditemStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
            physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds=snapshot.data.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],image: ds["Image"],price: ds["Price"])));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20,bottom: 30),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                ds["Image"],
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Name"],
                                      style: AppWidget.SemiBoldTextFieldStyle(),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "Freash and Healthy",
                                      style: AppWidget.LightTextFieldStyle(),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\$"+ds["Price"],
                                      style: AppWidget.SemiBoldTextFieldStyle(),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              })
              : CircularProgressIndicator();
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 10.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Color(0xffffffff),
                margin: EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Hello Pranay,",
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0, left: 20.0),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Delicious Food",
                          style: AppWidget.headlineTextFieldStyle(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Discover and Get Great Food",
                          style: AppWidget.LightTextFieldStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20.0),
                        child: showitems(),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3.2,
                        child: allItems(),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(child: allItemsVertically()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showitems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async{
            icecream = true;
            salad = false;
            pizza = false;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItems("Ice-cream");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: icecream ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset("images/ice-cream.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  color: icecream ? Colors.white : Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: ()  async {
            pizza = true;
            icecream = false;
            salad = false;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItems("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: pizza ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset("images/pizza.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  color: pizza ? Colors.white : Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            burger = true;
            pizza = false;
            icecream = false;
            salad = false;
            fooditemStream=await DatabaseMethods().getFoodItems("Burger");

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: burger ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset("images/burger.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  color: burger ? Colors.white : Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            salad = true;
            pizza = false;
            icecream = false;
            burger = false;
            fooditemStream=await DatabaseMethods().getFoodItems("Salad");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: salad ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset("images/salad.png",
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  color: salad ? Colors.white : Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
