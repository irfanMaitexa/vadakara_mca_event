import 'package:event/modules/auth/login_screen.dart';
import 'package:event/modules/user/profile/user_edit_profile_screen.dart';
import 'package:event/modules/user/user_add_complaint.dart';
import 'package:event/services/api_service.dart';
import 'package:event/utils/constants.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController =  TextEditingController();
  TextEditingController _phoneControllers = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService().fetchProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final profileData = snapshot.data!;

          _nameController.text = profileData['name'];
          _emailController.text = profileData['email'];
          _phoneControllers.text = profileData['phone'];






         
          return 
Center(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {

                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserEditProfileScreen(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneControllers.text,
                    ),
                  ),
                );

                },
                icon: Icon(
                  Icons.edit,
                  size: 30,
                  color: KButtonColor,
                ),
              )
            ],
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
              isEnabled: false,
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
              isEnabled: false,
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
              controller: _phoneControllers,
              isEnabled: false,
              borderColor: Colors.grey.shade500,
            ),
          ),
          const  SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children :  [
                
                
                Expanded(
                  child: CustomButton(
                  text: 'Log out',
                  color: KButtonColor,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
                  },
                            ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomButton(
                  text: 'complaint',
                  color: KButtonColor,
                  onPressed: () {
          
                    Navigator.push(context, MaterialPageRoute(builder:(context) => UserAddComplaintScreen(
                    ),));
                  },
                            ),
                ),
              
              ]
            ),
          )
        ],
      ),
    );
 
 
        }
      },
    );
  }
}



 
