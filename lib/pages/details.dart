import 'package:ecommerce2/services/database.dart';
import 'package:ecommerce2/services/sharedpreferences.dart';
import 'package:ecommerce2/widget/widget_support.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  String image,name,detail,price;
  Details({required this.name,required this.detail,required this.image,required this.price});




  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {


  int count=1,total=0;
  String ?id;

  getthesharedpref()async{
    id=await SharedPreferencesHelper().getUserId();
    setState(() {
    });
  }

  ontheLoad() async{
    await getthesharedpref();
    setState(() {

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheLoad();
    total=int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0,left: 20.0,right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
                child: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.black,)),
            Image.network(widget.image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 15.0,),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.name,style: AppWidget.SemiBoldTextFieldStyle(),),

                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if(count>1){
                      total=total-int.parse(widget.price);
                      --count;
                    }

                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.remove,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 20,),
                Text(count.toString(),style: AppWidget.SemiBoldTextFieldStyle(),),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    ++count;
                    total=total+int.parse(widget.price);
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.add,color: Colors.white,),
                   ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Text(widget.detail,
            maxLines: 3,
            style: AppWidget.LightTextFieldStyle(),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Text("Delivery Time",style: AppWidget.SemiBoldTextFieldStyle(),),
                SizedBox(width: 25.0,),
                Icon(Icons.alarm,color: Colors.black54,),
                SizedBox(width: 5.0,),
                Text("30 min",style: AppWidget.SemiBoldTextFieldStyle(),),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total price",style: AppWidget.boldTextFieldStyle(),),
                    Text("\$"+total.toString(),style: AppWidget.headlineTextFieldStyle(), ),
                  ],
                  ),
                  GestureDetector(
                    onTap: ()async{
                      Map<String,dynamic> addFoodToCart={
                        "Name":widget.name,
                        "Quantity":count.toString(),
                        "Total":total.toString(),
                        "Image":widget.image
                      };
                      await DatabaseMethods().addFoodToCart(addFoodToCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            "Add to cart successfull",
                            style: TextStyle(fontSize: 10.0),
                          )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add to Cart",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "Poppins"),),
                          SizedBox(width: 30,),
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.shopping_cart_outlined,color: Colors.white,),
                          ),
                          SizedBox(width: 8,),

                        ],
                      ),
                    ),
                  )

                ],
              ),
            )


          ],
        ),
      )
    );
  }
}
