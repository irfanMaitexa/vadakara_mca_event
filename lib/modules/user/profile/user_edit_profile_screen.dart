import 'package:event/Db/db_service.dart';
import 'package:event/services/api_service.dart';
import 'package:event/utils/constants.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen(
      {super.key,
      required this.name,
      required this.email,
      required this.phone});

  final String name;
  final String email;
  final String phone;

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    _nameController.text = widget.name;
    _emailController.text = widget.name;
    _phoneController.text = widget.phone;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loading
            ? CircularProgressIndicator(
                color: KButtonColor,
              )
            : Column(
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                      text: 'Confirm',
                      color: KButtonColor,
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        await ApiService().updateUserProfile(
                            context: context,
                            loginId: DbService.getLoginId()!,
                            name: _nameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                            );
                        Navigator.pop(context);

                        setState(() {
                          loading = false;
                        });
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
