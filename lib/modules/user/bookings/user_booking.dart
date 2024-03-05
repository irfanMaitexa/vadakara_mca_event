import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserBookingScreen extends StatefulWidget {
  const UserBookingScreen({super.key});

  @override
  State<UserBookingScreen> createState() => _UserBookingScreenState();
}

class _UserBookingScreenState extends State<UserBookingScreen> {


  final   _userBookingFormKey = GlobalKey<FormState>();
  final   _addreessController = TextEditingController();
  final  _peoplsCountController = TextEditingController();
  final   _budgetController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Book  your event'),

      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Form(
          key: _userBookingFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
               Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      hint: const Text('Select a category'),
                      elevation: 0,
                      isExpanded: true,
                      icon: const Icon(Icons.expand_more),
                      iconSize: 30,
                      underline: const SizedBox.shrink(),
                      items: <String>['Brithday', 'Marriage', 'Party', 'Other']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle selection here
                      },
                    ),
                  ),

                  SizedBox(height: 20,),


                   Text(
                'Add Address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16

                ),
                ),
                SizedBox(height: 10,),
      
              CustomTextField(
                hintText: 'Add your address', 
                controller: _addreessController,
                borderColor: Colors.grey,
      
                ),

                SizedBox(height: 20,),

              Text(
                'People Count',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16

                ),
                ),
                SizedBox(height: 10,),
      
              CustomTextField(
                hintText: 'Add peoples count', 
                controller: _peoplsCountController,
                borderColor: Colors.grey,
      
                ),
                SizedBox(height: 10,),


                 Text(
                'Add Squerfeet',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16

                ),
                ),
                SizedBox(height: 10,),
      
              CustomTextField(
                hintText: 'Add your squer feet', 
                controller: _addreessController,
                borderColor: Colors.grey,
      
                ),

                SizedBox(height: 10,),


                 Text(
                'Add Budget',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16

                ),
                ),
                SizedBox(height: 10,),
      
              CustomTextField(
                hintText: 'Add your  maximum Budget', 
                controller: _budgetController,
                borderColor: Colors.grey,
      
                ),

                Spacer(),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    text: 'Submit', 
                    onPressed: () {
                      
                    },
                    ),
                ),

                  SizedBox(height: 10,)

               
            
            ],
          ),
        ),
      ),
    

    );
  }
}