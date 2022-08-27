import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studyhelper/AddEvent.dart';
import 'package:studyhelper/Calendar.dart';
import 'package:studyhelper/Dashboard.dart';
import 'package:studyhelper/DatabaseHelper.dart';
import 'package:studyhelper/ListEvents.dart';
import 'package:studyhelper/TestUI.dart';
import 'package:studyhelper/MysqlData.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => const Home(),
      "/overview": (context) => const Overview(),
      "/dashboard":(context) => Dashboard(),
      "/addEvent":(context) => const AddEvent(),
      "/listEvents":(context) => const ListEvents(),
      "/test":(context) => const Test()

    },
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Declare variables for runtime

  // Create a list for all upcomming appointments for runtime
  List appointments = [];
  // Create an instance of DateTime.now() to get current time
  DateTime now = DateTime.now();
  // Empty Strings to hold selected Date/Time for adding events
  String formattedDate = "";
  String formattedTime = "";

  @override
  void initState() {
    super.initState();
    // Fetch data from Mysql to use in runtime
    fetchDataFromMysql();
  }

  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Study Helper"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(child: makeDarkText("Overview")),
              ),
              ListTile(
                title: const Text("Home"),
                onTap: () => Navigator.pushNamed(context, "/"),
              ),
              ListTile(
                title: const Text("Dashboard"),
                onTap: () => Navigator.pushNamed(context, "/dashboard"),
              ),
              ListTile(
                title: const Text("Calendar"),
                onTap: () => Navigator.pushNamed(context, "/overview"),
              ),
              ListTile(
                title: const Text("Add Event"),
                onTap: () => addEvent(),
              ),
              const ListTile(
                title: Text("List Events"),
                //onTap: () => Navigator.pushNamed(context, "/listEvents"),
              ),
              const ListTile(
                title: Text("TEST"),
                //onTap: () => DatabaseHelper().getDataFromMysql(),
              )
            ],
          ),
        ),
        body: Builder(builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/wallpaper.jpg"))),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: makeText("Upcomming events"),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: appointments.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                          color: Colors.white.withOpacity(0.8),
                          child:
                              Center(child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: formatEntry(index),
                              ))),
                    );
                  },
                  
                ),
              )
            ]),
          );
        }),
      ),
    );
  }

  // fetch mysql data to List appointments and refresh viewport
  void fetchDataFromMysql()async{

    appointments = await DatabaseHelper().getDataFromMysql();
    
    setState(() {});
  }

  // Format apppointments from Myql and create widget to display data
  Widget formatEntry(int index){
  return Text(
    "${appointments[index]["title"]}: ${appointments[index]["date"]}, ${appointments[index]["start"]} Uhr",
    style: const TextStyle(
      fontSize: 18
    ),
  );
  }

  void addEvent(){
    TextEditingController editingController = TextEditingController();
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Add an Event"),
        content: Wrap(
          children: [
            TextField(
              controller: editingController,
              decoration: const InputDecoration(
                labelText: "Title"
              ),
            ),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:20),
                child: ElevatedButton(
                  onPressed: ()async{
                    DateTime unformattedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(now.year),
                      lastDate: DateTime((now.year+1))
                    ) as DateTime;
                    TimeOfDay unformattedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now()) as TimeOfDay;
                    // Avoid use_build_context_synchronously by checking mounted property
                    if(!mounted) return;

                    // Format date and time
                    formattedTime = unformattedTime.format(context);
                    formattedDate = DateFormat('dd.MM.yyyy').format(unformattedDate);                
                    
                  },
                  child: const Text("Select Time")),
              ),
            ),
          ],
        ),
        actions: [
          // Save data
          TextButton(
            onPressed: () {
              if(editingController.text != "" && formattedDate != "" && formattedTime != ""){
                // Insert collected data into Mysql
                DatabaseHelper().insertIntoMysql(title: editingController.text, date: formattedDate, time: formattedTime);
                setState(() {
                  appointments.add({
                    "title": editingController.text,
                    "date": formattedDate,
                    "start": formattedTime
                  });
                });

                formattedTime = "";
                formattedDate = "";

                Navigator.pop(context);
              }
            }, 
            child: Text("Save")
          ),

          // Cancel action
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.red),)),
        ],
      );
    } );
  }
}

Widget makeText(String data) {
  return Text(
    data,
    style: const TextStyle(
        fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
  );
}

Widget makeDarkText(String data) {
  return Text(
    data,
    style: const TextStyle(
        fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold),
  );
}