import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserAddComplaintScreen extends StatefulWidget {
  const UserAddComplaintScreen({super.key});

  @override
  State<UserAddComplaintScreen> createState() => _UserAddComplaintScreenState();
}

class _UserAddComplaintScreenState extends State<UserAddComplaintScreen> {



final  addComplaint = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Add Complaint'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CustomTextField(
            hintText: 'Add Complaint', 
            controller: addComplaint,
            maxLine: 20,
            minLine: 5,
            ),

        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: 'Submit', onPressed: () {
            
          },)

        ],

      ),
    );
  }
}