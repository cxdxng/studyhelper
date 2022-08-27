import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studyhelper/main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  // Using syncfusion calendar:: https://pub.dev/packages/syncfusion_flutter_calendar
  
  TextEditingController title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("Study Helper"),
          actions: [
            Center(child: ElevatedButton(onPressed: (){showAddScreen();}, style: ElevatedButton.styleFrom(primary: Colors.grey[850]),child: Text("Add event")))
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
        body: SfCalendar(
          view: CalendarView.timelineMonth,
          dataSource: MeetingDataSource(getAppointments()),
        )
      ),
    );
  }

  void showAddScreen(){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Add an Appointment"),
        content: const Text("data"),
        
        actions: [
          ElevatedButton(onPressed:() => Navigator.pop(context), child: const Text("Add")),
          ElevatedButton(onPressed:() => Navigator.pop(context),style: ElevatedButton.styleFrom(primary: Colors.red), child: const Text("Cancel")),
        ],
      );
    });
  }
  
}

List<Appointment> meetings = <Appointment>[];

List<Appointment> getAppointments(){
  
  final DateTime startTime = DateTime(2022,8,26);
  final DateTime endTime= DateTime(2022,8,27);

  

  return meetings;
}


void addAppointment(String text){
  final DateTime startTime = DateTime(2022,8,22);
  final DateTime endTime= DateTime(2022,8,23);

  meetings.add(Appointment(startTime: startTime, endTime: endTime, subject: text, color: Colors.red));
}

void removeAppointment(){
  meetings.remove(0);
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;
  }
}




