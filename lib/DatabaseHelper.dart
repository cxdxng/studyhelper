import 'dart:convert';

import 'package:studyhelper/MysqlData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DatabaseHelper{

  Future<List> getDataFromMysql()async{
    Response response = await http.post(
     Uri.https(MysqlData().httpAuthority, "/studyhelper/getAppointments.php"),
     body: {"dbUser":MysqlData().user, "passwd": MysqlData().passwd}
    );

    return await jsonDecode(response.body);

  }

  void insertIntoMysql({required String title, required String date, required String time})async{
    http.post(
      Uri.https(MysqlData().httpAuthority, "/studyhelper/insert.php"),
      body: {"title": title, "date": date, "start": time}
    ); 
  }
}