import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampleapi3/model/category_model.dart';

class HomeScreenController {
  EmployeeModel? modelObj;
  Map<String, dynamic> decodedData = {};
  Future getData() async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
    final response = await http.get(url);

    ///http
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);
      modelObj = EmployeeModel.fromJson(decodedData);
    } else {
      print("error");
    }
  }

  Future deleteData(String? id) async {
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/$id/");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

  Future addData(String? name, String designation) async {
    ///add and post is similar
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/");
    final response = await http
        .post(url, body: {"employee_name": name, "designation": designation});
    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }

  Future updateData(
      {required String? name,
      required String? designation,
      required String? id}) async {
    ///add and post is similar
    final url = Uri.parse("http://3.92.68.133:8000/api/addemployee/$id/");
    final response = await http.put(url, body: {"employee_name": name, "designation": designation});
    if (response.statusCode == 200) {
      await getData();
      return true;
    } else {
      return false;
    }
  }
}
