import 'dart:convert';

import 'package:event/modules/staff/product_details_screen.dart';
import 'package:event/modules/staff/staff_event_details_screen.dart';
import 'package:event/modules/user/bookings/package_booking.dart';
import 'package:event/modules/user/product_details.dart';
import 'package:event/services/api_service.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StaffEventList extends StatelessWidget {
  const StaffEventList({super.key});

  Future<List<dynamic>> _fetchProductPackages() async {
    final url = Uri.parse('${ApiService.baseUrl}/api/user/view-products');
    final response = await http.get(url);

    if (response.statusCode == 201) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      return data;
    } else {
      throw Exception('Failed to load event packages');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchProductPackages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  snapshot.data!.length,
                  (index) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 200,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    snapshot.data![index]['image'],
                                    fit: BoxFit.fill,
                                    height: 120,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index]['name'],
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '₹${snapshot.data![index]['price']}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'view more',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StaffEventDetailsScreeen(
                                        details: snapshot.data![index],
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
