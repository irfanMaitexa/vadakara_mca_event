import 'package:event/modules/user/bookings/user_booking_confirmation.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class UserPackageBookingScreeen extends StatefulWidget {
  const UserPackageBookingScreeen({super.key, required this.image});

  final String image;

  @override
  State<UserPackageBookingScreeen> createState() =>
      _UserPackageBookingScreeenState();
}

class _UserPackageBookingScreeenState extends State<UserPackageBookingScreeen> {


  DateTime ?  newDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Book your package'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    newDateTime != null
                        ? Text(
                            '${newDateTime!.day.toString()}/${newDateTime!.month.toString()}/${newDateTime!.year.toString()}')
                        : const Text('Select date'),
                    CustomButton(
                      text: newDateTime != null ? 'change' : 'select',
                      onPressed: () async {
                        newDateTime = await showRoundedDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                          borderRadius: 16,
                        );
                        if (newDateTime != null) {
                          setState(() {});
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: 20,),
            
            Expanded(
              flex: 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Event management involves the planning, organization, and execution of various types of events, such as conferences, conventions, weddings, parties, and concerts. Event managers are responsible for coordinating all aspects of an event, including budgeting, scheduling, venue selection, catering, entertainment, and logistics. They work closely with clients to understand ',
                          maxLines: 4,
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Package',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Cake',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                        ),
                         Text(
                          'Food',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

              
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Book',
                onPressed: () {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserBookingConfirmScreen(),));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
