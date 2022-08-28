import 'package:flutter/material.dart';
import 'package:studyhelper/DatabaseHelper.dart';
import 'package:studyhelper/main.dart';

class ListEvents extends StatefulWidget {
  const ListEvents({Key? key}) : super(key: key);

  @override
  State<ListEvents> createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {

  List appointments = [];

  @override
  void initState() {
    super.initState();
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
                child: makeText("All events"),
              ),
              Expanded(
                child: ListView.builder(
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
                          )
                        )
                      ),
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

  // Format apppointments from Myql and create widget to display data
  Widget formatEntry(int index){
  return Text(
    "${appointments[index]["title"]}: ${appointments[index]["date"]}, ${appointments[index]["start"]} Uhr",
    style: const TextStyle(
      fontSize: 18
    ),
  );
  }

  // fetch mysql data to List appointments and refresh viewport
  void fetchDataFromMysql()async{

    appointments = await DatabaseHelper().getRecentDataFromMysql();
    
    setState((){});
  }
}