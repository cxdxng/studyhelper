import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);

  // Images for Cards
  AssetImage sis = const AssetImage("assets/sis.png");
  AssetImage horde = const AssetImage("assets/horde.png");
  AssetImage lea = const AssetImage("assets/lea.png");
  AssetImage leaIntern = const AssetImage("assets/leaIntern.png");
  AssetImage eva = const AssetImage("assets/eva.png");
  AssetImage eva2 = const AssetImage("assets/eva2.png");


  // Links to websites
  String linkSIS = "https://sis.h-brs.de";
  String linkHorde = "https://horde.inf.h-brs.de";
  String linkLea = "https://lea.h-brs.de";
  String linkLeaIntern = "https://lea.hochschule-bonn-rhein-sieg.de/goto.php?target=crs_214074";
  String linkEva = "https://eva.inf.h-brs.de";
  String linkEva2 = "https://eva2.inf.h-brs.de";



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Study Helper"),
        ),
        backgroundColor: Colors.blueGrey,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              makeRow(horde, sis, linkHorde, linkSIS),
              makeRow(lea, leaIntern, linkLea, linkLeaIntern),
              makeRow(eva, eva2, linkEva, linkEva2),
            ],
          ),
        ),
      ),
    );
    
  }

  Row makeRow(image1, image2, link1, link2){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              launchUrl(Uri.parse(link1));
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,80,0,80),
                child: Center(
                  child: Image(image: image1)
                ),
              ),
            ),
          ),
        ),
        Expanded(
          
          child: InkWell(
            onTap: () {
              launchUrl(Uri.parse(link2));
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0,80,0,80),
                child: Center(
                  child: Image(image: image2)
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}