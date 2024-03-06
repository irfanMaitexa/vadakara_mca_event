import 'package:event/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.white,
          title: const Text('Bookings'),
          centerTitle: true,
        ),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          )),
                      child: ListTile(
                        onTap: () {},
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.network(
                            'https://img.freepik.com/free-photo/mechanic-repairing-bicycle_23-2148138617.jpg?w=1380&t=st=1708497923~exp=1708498523~hmac=db0aa97cb4ebd6cb6b1a4e4f5a8da5d25d20e4a8be9b4bb5abeb10a7cbbcc7d0',
                          ),
                        ),
                        title: const Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        subtitle: const Text('booking time'),
                        trailing: CustomButton(
                          text: 'Status',
                          onPressed: () {},
                        ),
                      ),
                    )))
      ],
    );
  }
}
