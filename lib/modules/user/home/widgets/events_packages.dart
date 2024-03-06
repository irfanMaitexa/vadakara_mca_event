import 'package:event/modules/user/bookings/package_booking.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class EventPackagesWidget extends StatelessWidget {
  EventPackagesWidget({super.key});

  final turfList = [
    'https://cdn.pixabay.com/photo/2016/11/23/17/56/beach-1854076_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/23/17/56/beach-1854076_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/23/17/56/beach-1854076_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          childAspectRatio: .55,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          children: List.generate(
            turfList.length,
            (index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPackageBookingScreeen(
                      image: turfList[index],
                    ),
                  ),
                );
              },
              child: Container(
                width: 150,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        turfList[index],
                        fit: BoxFit.fill,
                        height: 120,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'location',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 15),
                          ),
                          const Text(
                            'Turf Park',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CustomButton(
                              text: 'Book',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserPackageBookingScreeen(
                                      image: turfList[index],
                                    ),
                                  ),
                                );
                              },
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
              ),
            ),
          )),
    );
  }
}
