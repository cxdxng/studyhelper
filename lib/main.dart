import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studyhelper/Calendar.dart';
import 'package:studyhelper/Dashboard.dart';
import 'package:studyhelper/DatabaseHelper.dart';
import 'package:studyhelper/ListEvents.dart';
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
      "/dashboard": (context) => Dashboard(),
      "/listEvents": (context) => const ListEvents(),
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

  // Unformatted date for uploading to mysql
  String mysqlDate = "";

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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () => addEvent(),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
            )
          ],
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
                title: const Text("Show all events"),
                onTap: () => Navigator.pushNamed(context, "/listEvents"),
              ),
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
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: appointments.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Card(
                        elevation: 2,
                        color: Colors.white.withOpacity(0.8),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: formatEntry(index),
                        ))),
                  );
                },
              )
            ]),
          );
        }),
      ),
    );
  }

  // fetch mysql data to List appointments and refresh viewport
  void fetchDataFromMysql() async {
    List mysqlData = await DatabaseHelper().getRecentDataFromMysql();

    // Limit upcomming events to a max of 5 elements
    if (mysqlData.length > 5) {
      appointments = mysqlData.sublist(0, 5);
    } else {
      appointments = mysqlData;
    }
    // Call setState to make changes visible
    setState(() {});
  }

  // Format apppointments from Myql and create widget to display data
  Widget formatEntry(int index) {
    return Text(
      "${appointments[index]["title"]}: ${appointments[index]["date"]}, ${appointments[index]["start"]} Uhr",
      style: const TextStyle(fontSize: 18),
    );
  }

  void addEvent() {
    TextEditingController editingController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add an Event"),
            content: Wrap(
              children: [
                TextField(
                  controller: editingController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          // Get date from usr
                          DateTime unformattedDate = await showDatePicker(
                              context: context,
                              locale: const Locale("de", "DE"),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(now.year),
                              lastDate: DateTime((now.year + 1))
                              // Cast as DateTime bc of async
                              ) as DateTime;
                          // Get time from usr
                          TimeOfDay unformattedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now()) as TimeOfDay;
                          // Avoid use_build_context_synchronously by checking mounted property
                          if (!mounted) return;
                          // Format date and time
                          formattedTime = unformattedTime.format(context);
                          formattedDate =
                              DateFormat('dd.MM.yyyy').format(unformattedDate);
                          // Because of format in Mysql, reformat date
                          mysqlDate =
                              DateFormat('yyyy.MM.dd').format(unformattedDate);
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
                    if (editingController.text != "" &&
                        formattedDate != "" &&
                        formattedTime != "") {
                      // Insert collected data into Mysql
                      DatabaseHelper().insertIntoMysql(
                          title: editingController.text,
                          date: mysqlDate,
                          time: formattedTime);
                      if (appointments.length < 5) {
                        setState(() {
                          appointments.add({
                            "title": editingController.text,
                            "date": formattedDate,
                            "start": formattedTime
                          });
                        });
                      }
                      // Reset values
                      formattedTime = "";
                      formattedDate = "";
                      // Close AlertDialog
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Saved successfully")));
                    }
                  },
                  child: const Text("Save")),

              // Cancel action
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
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
