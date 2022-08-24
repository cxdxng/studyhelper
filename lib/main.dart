import 'package:flutter/material.dart';
import 'package:studyhelper/Calendar.dart';
import 'package:studyhelper/Dashboard.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => const Home(),
      "/overview": (context) => const Overview(),
      "/dashboard":(context) => Dashboard()      

    },
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List entries = [
    "Vorlesung A",
    "Vorlesung B",
    "Klausur A",
    "Klausur B",
    "Klausur B",
    "Klausur B",
    "Klausur B",
  ];
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
                title: const Text("Calendar"),
                onTap: () => Navigator.pushNamed(context, "/overview"),
              ),
              ListTile(
                title: const Text("Dashboard"),
                onTap: () => Navigator.pushNamed(context, "/dashboard"),
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
                  itemCount: entries.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Card(
                          color: Color(0xff0FFF95),
                          child:
                              Center(child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Entry ${entries[index]}'),
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
