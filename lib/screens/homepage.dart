import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jra_app/screens/ReportPages/generalreport.dart';
import 'package:jra_app/screens/ReportPages/potholereport.dart';
import 'package:jra_app/screens/ReportPages/signagereport.dart';
import 'package:jra_app/screens/ReportPages/trafficlightreport.dart';

import '../constants.dart';


class HomePage extends StatefulWidget {
  static const String id = 'home';
  //const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];


  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      double value = controller.offset/199;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        //backgroundColor: Colors.grey,
        /*appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {

              },
            ),
          ],
        ),*/
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  print("General");
                  //Navigator.pushNamedAndRemoveUntil(context, GeneralPage.id, (route) => false);
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new GeneralPage())
                  );
                },
                  child: Container(
                    height: 160, ///Fixed height will cause errors
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.black, boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                    ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 0),
                          child: Text("General", style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                        ),),
                        //SizedBox(width: 60,),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Image.asset("assets/images/general.png", scale: 1.5,),
                        ),),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  /*Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Description",
                                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                              ),
                                              *//*Text(
                                                    post["brand"],
                                                    style: const TextStyle(fontSize: 17, color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "\$ ${post["price"]}",
                                                    style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                                  )*//*
                                            ],
                                          ),*/
                                ],
                              ),
                              /*Image.asset(
                                          "assets/images/${post["image"]}",
                                          height: double.infinity,
                                        )*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  print("Traffic Signal");
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new TrafficPage())
                  );
                },
                child: Container(
                  height: 160, ///Fixed height will cause errors
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.black, boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                  ]),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 0),
                          child: Text("Traffic Signal", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white,
                          ),),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.0,),
                          child: Image.asset("assets/images/complete.png", scale: 1,),
                        ),
                      ),
                      /*SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(typeofissue, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      ),),
                    ),
                    Divider(thickness: 2, color: Colors.black,),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(description, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400
                      ),),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(12.0,),
                      child: GestureDetector(
                        onTap: (){

                          print("tapped");
                        },
                        child: Text(locationUrl, style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                        ),),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                          child: Text(status, style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                /*Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Description",
                                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            ),
                                            *//*Text(
                                                  post["brand"],
                                                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "\$ ${post["price"]}",
                                                  style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                                )*//*
                                          ],
                                        ),*/
                              ],
                            ),
                            /*Image.asset(
                                        "assets/images/${post["image"]}",
                                        height: double.infinity,
                                      )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  print("Pothole");
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new PotholePage())
                  );
                },
                child: Container(
                  height: 160, ///Fixed height will cause errors
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.black, boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                  ]),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, ),
                          child: Text("Pothole", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white,
                          ),),
                        ),
                      ),
                      
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.0,),
                          child: Image.asset("assets/images/potholes.png", scale: 1.2,),
                        ),
                      ),
                      /*SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(typeofissue, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      ),),
                    ),
                    Divider(thickness: 2, color: Colors.black,),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(description, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400
                      ),),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(12.0,),
                      child: GestureDetector(
                        onTap: (){

                          print("tapped");
                        },
                        child: Text(locationUrl, style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                        ),),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                          child: Text(status, style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                /*Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Description",
                                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            ),
                                            *//*Text(
                                                  post["brand"],
                                                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "\$ ${post["price"]}",
                                                  style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                                )*//*
                                          ],
                                        ),*/
                              ],
                            ),
                            /*Image.asset(
                                        "assets/images/${post["image"]}",
                                        height: double.infinity,
                                      )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  print("Signage");
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) =>
                      new SignagePage())
                  );
                },
                child: Container(
                  height: 160, ///Fixed height will cause errors
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.black, boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 20.0),
                  ]),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0,),
                          child: Text("Signage", style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white
                          ),),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.0,),
                          child: Image.asset("assets/images/signage.png", scale: 1,),
                        ),
                      ),
                      /*SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(typeofissue, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold
                      ),),
                    ),
                    Divider(thickness: 2, color: Colors.black,),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Text(description, style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400
                      ),),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(12.0,),
                      child: GestureDetector(
                        onTap: (){

                          print("tapped");
                        },
                        child: Text(locationUrl, style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal, color: Colors.blue
                        ),),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 12.0),
                          child: Text(status, style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),*/
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                /*Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Description",
                                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            ),
                                            *//*Text(
                                                  post["brand"],
                                                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "\$ ${post["price"]}",
                                                  style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                                                )*//*
                                          ],
                                        ),*/
                              ],
                            ),
                            /*Image.asset(
                                        "assets/images/${post["image"]}",
                                        height: double.infinity,
                                      )*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),

        ),
        /*Padding(
          padding: const EdgeInsets.only(),
          child: Container(
            height: size.height,
            child: Column(
              children: <Widget>[
                *//*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),*//*
                const SizedBox(
                  height: 10,
                ),
                *//*AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: closeTopContainer ? 0 : 1,
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: size.width,
                      alignment: Alignment.topCenter,
                      height: closeTopContainer ? 0 : categoryHeight,
                      child: categoriesScroller),
                ),*//*
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform: Matrix4.identity()..scale(scale, scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                              heightFactor: 1.0,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),*/
      );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Tips",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Read more",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Map",
                          style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Open Map",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Super\nSaving",
                        style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 Items",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
