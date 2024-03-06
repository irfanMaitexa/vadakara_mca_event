import 'dart:convert';

import 'package:event/utils/api_end_points.dart';
import 'package:event/utils/api_helper.dart';

class AuthApiService {
  final _apiHelper = ApiHelper();

  //user registration
  Future<bool> userRedistartion(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    try {
      var response = await _apiHelper.postData(
          url: baseUrl + userRegistration,
          body: jsonEncode({
            "name": name,
            "phone": phone,
            "email": email,
            "password": password
          }));

      if (response.statusCode == 201) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  //staff registration
  Future<bool> staffRedistartion(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    try {
      var response = await _apiHelper.postData(
          url: baseUrl + staffRegistrationScreen,
          body: jsonEncode({
            "name": name,
            "phone": phone,
            "email": email,
            "password": password
          }));

      if (response.statusCode == 201) {
        return true;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  //login
  Future<Map<String, dynamic>> Login(
      {required String email, required String password}) async {
    try {
      var response = await _apiHelper.postData(
        url: baseUrl + login,
        body: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
