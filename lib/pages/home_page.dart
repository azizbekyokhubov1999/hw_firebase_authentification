import 'package:flutter/material.dart';
import 'package:hw_firebase_authentification/pages/register_page.dart';
import '../services/firebase_auth_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()async{
              await AuthService.logOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
              onPressed: ()async{
            await AuthService.deleteAccount();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
            },
              icon: const Icon(Icons.delete)
          ),
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Text(
                'Home Page',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: Text(
                  'C',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Hi User001',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Congrats!\nYour account  successfully created.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'User name:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // User name goes here
              SizedBox(height: 10),
              Text(
                'User email:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // User email goes here
              SizedBox(height: 10),
              Text(
                'Password:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Password goes here
            ],
          ),
        ),
      ),
    );
  }
}
