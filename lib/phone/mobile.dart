import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mazdoor_user/phone/otp.dart'; // Ensure the correct import for your OTP screen

class Mobile extends StatefulWidget {
  @override
  _MobileState createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  final TextEditingController _phoneController = TextEditingController();
  var phone = "";
  bool _isValidNumber = false;

  void _checkPhoneNumber(String value) {
    setState(() {
      phone = value; // Update the phone variable with the entered value
      _isValidNumber = RegExp(r'^\d{10}$')
          .hasMatch(value); // Check if it's a 10-digit number
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent the screen from resizing automatically
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/mazdoor_background.pngzz', // Path to your single image asset
              fit: BoxFit.cover,
            ),
          ),
          // Main content with dynamic sizing
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome text
                Text(
                  'WelcomeMazdoor App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Change color if needed
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    // Country code input field
                    Expanded(
                      flex: 1,
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '+91', // Country code
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Phone number input field
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        onChanged: _checkPhoneNumber,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your mobile number',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // "Continue" button
                SizedBox(
                  width: double.infinity, // Button covers the full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Black background color
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _isValidNumber
                        ? () async {
                            // Prepare the full phone number
                            String fullPhoneNumber = '+91$phone';

                            // Start verification
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: fullPhoneNumber,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {
                                FirebaseAuth.instance
                                    .signInWithCredential(credential);
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Verification failed: ${e.message}'),
                                  ),
                                );
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OTP(verificationId: verificationId),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                print(
                                    'Code auto retrieval timeout: $verificationId');
                              },
                            );
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Please enter a valid 10-digit number'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        10), // Smaller space between button and consent text
                Text(
                  'By proceeding, you consent to get calls, WhatsApp, or SMS/RCS messages, including by automated means, from EasyMazdoor and its affiliates to the number provided.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40), // Adjust bottom spacing for aesthetics
              ],
            ),
          ),
        ],
      ),
    );
  }
}
