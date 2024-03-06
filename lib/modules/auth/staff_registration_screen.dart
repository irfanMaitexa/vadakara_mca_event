import 'package:event/modules/auth/login_screen.dart';
import 'package:event/modules/auth/services/auth_api_service.dart';
import 'package:event/utils/constants.dart';
import 'package:event/utils/validator.dart';
import 'package:event/widgets/custom_button.dart';
import 'package:event/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class StaffRegistrationScreen extends StatefulWidget {
  const StaffRegistrationScreen({super.key});

  @override
  State<StaffRegistrationScreen> createState() =>
      _StaffRegistrationScreenState();
}

class _StaffRegistrationScreenState extends State<StaffRegistrationScreen> {
  String? emailError;
  String? passwordError;

  bool _obscureText = true;

  bool _loading = false;

  final _nameControllers = TextEditingController();
  final _phoneControllers = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameControllers.dispose();
    _phoneControllers.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SignUp',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                  hintText: 'Enter name',
                  controller: _nameControllers,
                  borderColor: Colors.grey.shade300),
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: 'Enter phone',
                  controller: _phoneControllers,
                  input: TextInputType.number,
                  borderColor: Colors.grey.shade300),
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: 'Ente email',
                  controller: _emailController,
                  errorText: emailError,
                  borderColor: Colors.grey.shade300),
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
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: 'Confirm password',
                  controller: _confirmPasswordController,
                  borderColor: Colors.grey.shade300),
              const SizedBox(height: 30),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: KButtonColor,
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'SIGN UP',
                        onPressed: () {
                          _signUpHandler(context);
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  _signUpHandler(BuildContext context) async {

    
    setState(() {
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
    });

    if (emailError == null &&
        passwordError == null &&
        _nameControllers.text.isNotEmpty &&
        _phoneControllers.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        try {
          setState(() {
            _loading = true;
          });

          var data = await AuthApiService().staffRedistartion(
            name: _nameControllers.text,
            phone: _phoneControllers.text,
              email: _emailController.text,
               password: _passwordController.text
              );


             if(context.mounted){
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false);
             }



          setState(() {
            _loading = false;
          });
        } catch (e) {

         if(context.mounted){

           ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(content: Text(e.toString())));
          
         }

         setState(() {
            _loading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Password not match')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
     
    }
  }
}
