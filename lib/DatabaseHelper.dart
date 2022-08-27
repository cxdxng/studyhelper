import 'dart:convert';

import 'package:studyhelper/MysqlData.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DatabaseHelper{

  List mysqlData = [];

  void getDataFromMysql()async{
    print("dyk");
     Response response = await http.post(
      Uri.https(MysqlData().httpAuthority, "/studyhelper/getAppointments.php"),
      body: {"dbUser":MysqlData().user, "passwd": MysqlData().passwd}
    );

    mysqlData = await jsonDecode(response.body);
    print(mysqlData);
  }
}