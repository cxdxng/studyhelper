import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studyhelper/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  // Using syncfusion calendar:: https://pub.dev/packages/syncfusion_flutter_calendar

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
        body: Container(
            child: SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: DateTime.monday,
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        )),
      ),
    );
  }
}
