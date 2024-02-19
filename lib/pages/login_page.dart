import 'package:flutter/material.dart';
import 'package:hw_firebase_authentification/pages/register_page.dart';
import 'package:hw_firebase_authentification/services/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isRegis = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80.0),
                Image.asset('assets/images/login_img.png', height: 120),
                const SizedBox(height: 50.0),
                const Text('Login', style: TextStyle(fontSize: 25.0,
                    color: Color.fromRGBO(69, 75, 96, 1),
                    fontWeight: FontWeight.bold
                )),
                const SizedBox(height: 8.0),
                isRegis ? const Text('Enter your email and password to login',
                  style: TextStyle(color: Color.fromRGBO(69, 75, 96, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                  ),)
                    : const Text('Invalid email or password',
                  style: TextStyle(color: Colors.redAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.w700
                  ),),
                const SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    validator: validateLEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(
                            69, 75, 96, 1), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(69, 75, 96, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Forgot email?',
                    style: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 50,
                  child: TextFormField(
                    controller: passwordController,
                    validator: validateLPassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(
                            69, 75, 96, 1), width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(69, 75, 96, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_key.currentState!.validate()){
                        await AuthService.loginUser(
                            context, email: emailController.text.trim(),
                            password: passwordController.text.trim());
                        setState(() {});
                      }
                    },
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    color: const Color.fromRGBO(69, 75, 96, 1),
                    child: const Text('Login',
                      style: TextStyle(color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text('Or login in with',
                    style: TextStyle(
                        color: Color.fromRGBO(69, 75, 96, 1)
                    )),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_translate),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook),
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account?',
                      style: TextStyle(color: Color.fromRGBO(69, 75, 96, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => const RegisterPage()));
                    },
                      child: const Text('Register',
                        style: TextStyle(color: Color.fromRGBO(69, 75, 96, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),

                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Need help? Visit our ',
                      style: TextStyle(color: Color.fromRGBO(69, 75, 96, 1)),
                    ),
                    Text(' help center',
                      style: TextStyle(color: Color.fromRGBO(69, 75, 96, 1),
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  String? validateLPassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      isRegis = false;
      return 'Password is required.';
    }

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(formPassword)) {
      isRegis = false;
      return '''
      Password must be at least 8 characters, include an uppercase letter, number and symbol.
      ''';
    }

    return null;
  }

  String? validateLEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      isRegis = false;
      return 'E-mail address is required.';
    }
    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) {
      isRegis = false;
      return 'Invalid E-mail Address format.';
    }

    return null;
  }
}