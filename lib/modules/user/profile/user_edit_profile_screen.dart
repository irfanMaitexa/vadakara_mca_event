
import 'package:event/utils/constants.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserEditProfileScreen extends StatelessWidget {
  UserEditProfileScreen({super.key});

  
TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _phoneController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'name',
                controller: _nameController,
                
                borderColor: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'email',
                controller: _emailController,
                
                borderColor: Colors.grey.shade500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextField(
                hintText: 'phone',
                controller: _phoneController,
              
                borderColor: Colors.grey.shade500,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: 'Confirm',
                color: KButtonColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}