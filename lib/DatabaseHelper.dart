import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:studyhelper/MysqlData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DatabaseHelper{

  List appointments = [];


  // Only get events that haven't occured yet
  Future<List> getRecentDataFromMysql()async{
    Response response = await http.post(
     Uri.https(MysqlData().httpAuthority, "/studyhelper/getAppointments.php"),
     body: {"dbUser":MysqlData().user, "passwd": MysqlData().passwd}
    );
    // Decode response into List
    List fullMysqlData = await jsonDecode(response.body);

    // Set appointments to recent appointments
    appointments = await checkDates(fullMysqlData);
    return appointments;
  }

  Future<List> checkDates(List fullMysqlData)async{

    // Get current time and format it    
    DateTime dtNow = DateTime.parse(DateFormat("yyyy-MM-dd").format(DateTime.now()));

    // Create a list to hold future events
    List futureEvents = [];

    // Check all data if it is after now and if so,
    // add it to the futureEvents List
    for (var i = 0; i < fullMysqlData.length; i++) {
      DateTime dt1 = formatSQLDate(fullMysqlData[i]["date"]);
      if(dt1.isAfter(dtNow)){
        futureEvents.add(fullMysqlData[i]);
      }
    }
    return futureEvents;
  }

  // Parses date of event into DateTime object
  DateTime formatSQLDate(String date){
    List tmp = date.split(".");
    String dt1 = "${tmp[2]}-${tmp[1]}-${tmp[0]}";

    return DateTime.parse(dt1);
  }

  // Insert new events into Mysql
  void insertIntoMysql({required String title, required String date, required String time})async{
    http.post(
      Uri.https(MysqlData().httpAuthority, "/studyhelper/insert.php"),
      body: {"title": title, "date": date, "start": time}
    ); 
  }
}