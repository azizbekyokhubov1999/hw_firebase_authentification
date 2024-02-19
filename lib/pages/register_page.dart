import 'package:flutter/material.dart';
import 'package:hw_firebase_authentification/services/firebase_auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String errorMassage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/r_image.png', height: 120),
              const SizedBox(height: 30),
              const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,
                color: Color.fromRGBO(69, 75, 96, 1),
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Enter your details to register',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(69, 75, 96, 1),),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: TextFormField(
                  controller: nameController,
                  validator: validateName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(69, 75, 96, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(69, 75, 96, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 17.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: TextFormField(
                  controller:  phoneNumberController,
                  validator: validateMobileNumber,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(69, 75, 96, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 17.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: TextFormField(
                  controller: passwordController,
                  validator: validatePassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(69, 75, 96, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 17),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 50,
                child: TextFormField(
                  controller: passwordConfirmController,
                  validator: (value) => validateConfirmPassword(passwordController.text, value),
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(69, 75, 96, 1), width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 17.0),
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {
                      value = true;
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree with the terms and conditions',
                      style: TextStyle(fontSize: 14.0, color: Color.fromRGBO(69, 75, 96, 1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 17.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: MaterialButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()){
                    await AuthService.registerUser(context, name: nameController.text.trim(), email: emailController.text.trim(), phoneNumber: phoneNumberController.text.trim(), password: passwordController.text.trim());
                    setState(() {});
                    }
                  },
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  color: const Color.fromRGBO(69, 75, 96, 1),
                  child: const Text('Register',
                    style: TextStyle(color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Need help? Visit our help center',
                  style: TextStyle(fontSize: 14.0, color:  Color.fromRGBO(69, 75, 96, 1) ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String? validateName(String? value) {
  return (value == null || value.trim().isEmpty) ? 'Name cannot be empty' : null;
}

String? validateMobileNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Mobile number cannot be empty';
  }

  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter a valid mobile number';
  }
  return null;
}


String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty) {
    return 'E-mail address is required.';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) {
    return 'Invalid E-mail Address format.';
  }

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty) {
    return 'Password is required.';
  }

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(formPassword)) {
    return '''
      Password must be at least 8 characters, include an uppercase letter, number and symbol.
      ''';
  }

  return null;
}


String? validateConfirmPassword(String? password, String? confirmPassword) {
  if (confirmPassword == null || confirmPassword.trim().isEmpty) {
    return 'Confirm password cannot be empty';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  return null;
}