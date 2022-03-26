import 'package:flutter/material.dart';
import 'package:jra_app/screens/TicketsLogged/TicketsLogged.dart';

class TicketLoggedPage extends StatelessWidget {
  static const id = "TicketsLoggedPage";
  const TicketLoggedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success'),),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
              child: Text('YOUR TICKET HAS BEEN LOGGED',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
              ),
            ),
            
            SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Your ticket has been logged, your response will be sent to the specific teams. '
                  'Please continue checking the status of your logged ticket. Your ticket must be assigned within the next 60 minutes. If not '
                  'the system will flag your ticket for attention',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black
              ),),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              padding: const EdgeInsets.only(
                left: 90, right: 90, top: 15, bottom: 10,),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new TicketsLogged())
                );
              },
              elevation: 10,
              color: Colors.amber,
              child: Container(
                height: 25,
                child: Text("Logged tickets",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight
                      .bold),),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30)
              ),
            ),
          ],
        ),

    );
  }
}
