import 'dart:convert';

import 'package:event/Db/db_service.dart';
import 'package:event/modules/user/bookings/user_booking_confirmation.dart';
import 'package:event/utils/api_end_points.dart';
import 'package:flutter/material.dart';
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


  Future<void> addComplaint(String loginId, String complaint,BuildContext context) async {
  final url = Uri.parse('$baseUrl/api/user/add-complaint/$loginId');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'complaint': complaint,
    },
  );

  print(response.body);

  if (response.statusCode == 200) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonDecode(response.body)['Message'])));

    
    
  } else {

    throw Exception(jsonDecode(response.body)['Message']);
  }
}

//view complaint
Future<List<dynamic>> fetchComplaints() async {
    final loginId = DbService.getLoginId();
    final url = Uri.parse('$baseUrl/api/user/view-complaint/$loginId');
    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 201) {

      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  //add book event
  Future<void> bookEvent(BuildContext context, String loginId, String eventId, String date, String location) async {
  final url = Uri.parse('$baseUrl/api/user/book-event/$loginId/$eventId');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'date': date,
        'location': location,
      },
    );

    if (response.statusCode == 201) {
      print('Event booked successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event booked successfully')),
      );
    } else {
      print('Failed to book event: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book event: ${response.statusCode}')),
      );
    }
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


Future<List<dynamic>> viewCart(String loginId) async {
  final url = Uri.parse('$baseUrl/api/user/view-cart/$loginId');
  final response = await http.get(url);

  print(response.body);

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception('Failed to load cart data');
  }
}


Future<void> addAddress(
  String loginId,
  Map<String,dynamic> data,
  BuildContext context
) async {
  final url = Uri.parse('$baseUrl/api/user/add-address/$loginId');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: data,
    );

    if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Address added!!!!!!!')));
   Navigator.pop(context,data);
   
    } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Faild!!!')));
              

    }
  } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Faild!!!!!!!')));
  }
}



Future<void> addCartItem(String loginId, String productId, String price) async {
  final url = Uri.parse('$baseUrl/api/user/add-cart/$loginId/$productId');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'price': price,
      },
    );

    if (response.statusCode == 200) {
      print('Item added to cart successfully');
    } else {
      print('Failed to add item to cart: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}


Future<void> placeOrder(BuildContext context) async {
  final url = Uri.parse('$baseUrl/api/user/place-order-prod/${DbService.getLoginId()}');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully')),


      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => UserBookingConfirmScreen(),));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order: ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}






  








}//close



