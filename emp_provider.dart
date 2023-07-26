import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:employee/models/emps.dart';
import 'package:http/http.dart' as http;

class EmpProvider extends ChangeNotifier {
  static const apiEndpoint =
      'https://run.mocky.io/v3/fe65cd4d-a1ae-4116-a658-158cfbf335ee';

  bool isLoading = true;
  String error = '';
  Emp emp = Emp(data: []);
  Emp serachedemps = Emp(data: []);
  String searchText = '';

  //
  getDataFromAPI() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        emp = empFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    updateData();
  }

  updateData() {
    serachedemps.data.clear();
    if (searchText.isEmpty) {
      serachedemps.data.addAll(emp.data);
    } else {
      serachedemps.data.addAll(emp.data
          .where((element) =>
              element.name.toLowerCase().startsWith(searchText))
          .toList());
    }
    notifyListeners();
  }

  search(String username) {
    searchText = username;
    updateData();
  }
  //
}
