import 'package:flutter/material.dart';

import 'TaxiButton.dart';

class WaitDialog extends StatelessWidget {

  final  String status, heading;
  WaitDialog({required this.status, required this.heading});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Colors.transparent,
          child: Container(
              margin: EdgeInsets.all(4.0),
              width: double.infinity,

              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4)
              ),
              /*child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 5,),

                  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),),
                  SizedBox(width: 25.0,),
                  Text(status, style: TextStyle(fontSize: 15),),
                  SizedBox(height: 30,),

                  Container(
                    width: 230,
                    child: TaxiButton(
                      title: 'Search Destination',
                      color: Colors.amber,
                      onPressed: (){

                        //Navigator.pop(context, 'close');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));

                      },
                    ),
                  ),
                ],
              ),
            ),*/
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  SizedBox(height: 20,),
                  /*Padding(
                  padding: const EdgeInsets.only(left: 230.0),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context, 'close');
                      },
                      child: Icon(Icons.close)),
                ),*////Close icon
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(heading, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white
                    ), textAlign: TextAlign.center,),
                  ),
                  //CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(status, textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white
                    ),),
                  ),

                  SizedBox(height: 30,),
                  /*SizedBox(
                  width: 260.0,
                  child: Container(
                    child: Text(
                      Provider.of<AppData>(context).pickupAddress != null
                          ? Provider.of<AppData>(context).pickupAddress.placeName
                          : "Check if your location is turned on..",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10.0),),
                  ),
                ),*////Not needed anymore
                  SizedBox(height: 30,),
                  Container(
                    width: 230,
                    child: RaisedButton(
                      padding: const EdgeInsets.only(
                        left: 90, right: 90, top: 15, bottom: 10,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      elevation: 10,
                      color: Colors.amber,
                      child: Container(
                        height: 25,
                        child: Text("Close",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight
                              .bold),),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30)
                      ),
                    ),
                  ),
                  SizedBox(height: 40,)
                ],
              )
          ),
        ),
      ),
    );
  }
}