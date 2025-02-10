import 'package:flutter/material.dart';
import 'signup.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedRole = 'User'; // Default selected role

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650), // Animation duration
        pageBuilder: (context, animation, secondaryAnimation) => const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Start position (Right to left)
          const end = Offset.zero; // End position
          const curve = Curves.easeInOut; 

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(72, 66, 109, 1), // Background color
        body: Column(
          children: [
            const SizedBox(height: 125), // Adds spacing at the top
            Center(
              child: Image.asset(
                'assets/image.png', // Corrected asset path
                height: 50, // Adjust size as needed
                width: 280,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 80), // Spacing between image and container

            Expanded(
              child: Container(
                height: 100,
                width: 400,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(49, 44, 81, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Text(
                        'We’re glad to see you back. Sign in to explore more!',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          color: Color.fromRGBO(188, 195, 210, 1),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 15),

                      // Radio buttons
                      Align(
                        alignment: Alignment.centerLeft, // Moves everything to the left
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Ensures text & button stay together
                              children: [
                                SizedBox(
                                  width: 30, // Adjust this value for size
                                  height: 50,
                                child :Radio<String>(
                                  value: 'User',
                                  groupValue: _selectedRole,
                                  activeColor: Color.fromRGBO(240, 195, 142, 1),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  },
                                ),),
                                const SizedBox(width: 10), // Adjust spacing
                                const Text(
                                  'User',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start, // Ensures text & button stay together
                              children: [
                                SizedBox(
                                  width: 30, // Adjust this value for size
                                  height: 50,
                               child: Radio<String>(
                                  value: 'Doctor',
                                  groupValue: _selectedRole,
                                  activeColor: Color.fromRGBO(240, 195, 142, 1),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  },
                                ),),
                                const SizedBox(width: 10), // Adjust spacing
                                const Text(
                                  'Doctor',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                  ),
                                ),
                                ],
                            ),
                      ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Continue with Gmail
                      GestureDetector(
                        onTap: () {
                          _navigateToSignUp(context);
                        },
                        child: Container(
                          height: 60,
                          width: 350,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(72, 66, 109, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/google.png', height: 25, width: 25),
                                const Text(
                                  '   Continue With Gmail',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 15,fontFamily: 'Outfit'),
                                ),
                                const Spacer(),
                                const Text(
                                  '>',
                                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Continue with Apple
                      GestureDetector(
                        onTap: () {
                          _navigateToSignUp(context);
                        },
                        child: Container(
                          height: 60,
                          width: 350,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(72, 66, 109, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/apple.png', height: 25, width: 25),
                                const Text(
                                  '   Continue With Apple',
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 15,
                                    fontFamily: 'Outfit',
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  '>',
                                  style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
