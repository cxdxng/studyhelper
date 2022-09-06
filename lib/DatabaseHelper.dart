import 'dart:convert';
import 'package:studyhelper/MysqlData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DatabaseHelper {
  List appointments = [];

  // Only get events that haven't occured yet
  Future<List> getRecentDataFromMysql() async {
    Response response = await http.post(
        Uri.https(
            MysqlData().httpAuthority, "/studyhelper/getAppointments.php"),
        body: {"dbUser": MysqlData().user, "passwd": MysqlData().passwd});
    // Decode response into List

    List fullMysqlData = await jsonDecode(response.body);

    // Set appointments to recent appointments
    // DYYYYk SQL makes it easy you ape
    //appointments = await checkDates(fullMysqlData);
    return fullMysqlData;
  }

  // Insert new events into Mysql
  void insertIntoMysql(
      {required String title,
      required String date,
      required String time}) async {
    http.post(Uri.https(MysqlData().httpAuthority, "/studyhelper/insert.php"),
        body: {"title": title, "date": date, "start": time});
  }
}
