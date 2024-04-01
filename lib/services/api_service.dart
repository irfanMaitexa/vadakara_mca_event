import 'dart:convert';

import 'package:event/Db/db_service.dart';
import 'package:event/utils/api_end_points.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://event-management-server-d9c9.onrender.com';

  Future<bool> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/register/user');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<int> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      DbService.setLoginId(data['login_id']);


      return data['role'];
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }


  //profile
   Future<Map<String, dynamic>> fetchProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/api/profile/user/${DbService.getLoginId()}'));
    

    print(Uri.parse('$baseUrl/api/profile/user/${DbService.getLoginId()}'));
    if (response.statusCode == 200) {




      return jsonDecode(response.body)['data'][0];
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

//login


