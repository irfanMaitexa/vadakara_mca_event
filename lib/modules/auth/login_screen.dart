// ignore_for_file: prefer_const_constructors

import 'package:event/Db/db_service.dart';
import 'package:event/modules/auth/services/auth_api_service.dart';
import 'package:event/modules/auth/staff_registration_screen.dart';
import 'package:event/modules/auth/user_registrattion_screen.dart';
import 'package:event/modules/staff/staff_root_screen.dart';
import 'package:event/modules/user/user_root_screen.dart';
import 'package:event/utils/constants.dart';
import 'package:event/utils/validator.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.white),
  );

  String? emailError;
  String? passwordError;

  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Sign in',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
            ),
            CustomTextField(
              hintText: 'Enter Email',
              controller: _emailController,
              errorText: emailError,
              borderColor: Colors.grey.shade300,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: 'Enter password',
              controller: _passwordController,
              errorText: passwordError,
              obscureText: _obscureText,
              borderColor: Colors.grey.shade300,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forget password',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: KButtonColor,
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    child: CustomButton(
                      text: 'SIGN IN',
                      color: KButtonColor,
                      onPressed: () {
                        _loginHandler();
                      },
                    ),
                  ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dont have an account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign up'),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 30,
                                  ))
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 50,
                                child: CustomButton(
                                  text: 'USER',
                                  color: KButtonColor,
                                  onPressed: ()  async{
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            UserRegistrationScreen(),
                                      ),
                                    );

                                    
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 50,
                                child: CustomButton(
                                  text: 'STAFF',
                                  color: KButtonColor,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StaffRegistrationScreen(),
                                      ),
                                    );

                                    
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: KButtonColor, fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _loginHandler() async {
    setState(() {
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
    });
    if (emailError == null && passwordError == null) {
      try {
        setState(() {
          _loading = true;
        });

        var data = await AuthApiService().Login(
          email: _emailController.text,
          password: _passwordController.text,
        );


        await DbService.setAuth(data['data']['role']);


        if (data['data']['role'] == 'user') {
          

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => UserRootScreen(),
                ),
                (route) => false);
                
          }
        }

        if (data['data']['role'] == 'staff') {
          

          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => StaffRootScreen(),
                ),
                (route) => false);
                
          }
        }

        setState(() {
          _loading = false;
        });
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
