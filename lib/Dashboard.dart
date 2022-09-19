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
  AssetImage stundenplan = const AssetImage("assets/stundenplan.png");
  AssetImage zeitplanImage = const AssetImage("assets/zeitplanImage.png");

  // Links to websites
  String linkSIS = "https://sis.h-brs.de";
  String linkHorde = "https://horde.inf.h-brs.de";
  String linkLea = "https://lea.h-brs.de";
  String linkLeaIntern =
      "https://lea.hochschule-bonn-rhein-sieg.de/goto.php?target=crs_214074";
  String linkEva = "https://eva.inf.h-brs.de";
  String linkEva2 = "https://eva2.inf.h-brs.de";
  String stundenplanEva =
      "https://eva2.inf.h-brs.de/stundenplan/anzeigen/?weeks=39%3B40%3B41%3B42%3B43%3B44%3B45%3B46%3B47%3B48%3B49%3B50%3B51%3B54%3B55&days=1-7&mode=table&identifier_semester=%23SPLUS3D9E23&show_semester=&identifier_dozent=&identifier_raum=&term=0b8b1bad6d13dd08923c28a992610050";

  String zeitplan = "https://horde.inf.h-brs.de/fbz.html";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Study Helper"),
        ),
        backgroundColor: Colors.grey,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              makeRow(horde, sis, linkHorde, linkSIS),
              makeRow(lea, leaIntern, linkLea, linkLeaIntern),
              makeRow(eva, eva2, linkEva, linkEva2),
              makeRow(stundenplan, zeitplanImage, stundenplanEva, zeitplan),
            ],
          ),
        ),
      ),
    );
  }

  Row makeRow(image1, image2, link1, link2) {
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
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                child: Center(child: Image(image: image1)),
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
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 80),
                child: Center(child: Image(image: image2)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
