import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  @override
  _ChangePhoneNumberScreenState createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  final TextEditingController _oldPhoneController = TextEditingController();
  final TextEditingController _newPhoneController = TextEditingController();
  final TextEditingController _confirmPhoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _isOtpSent = false;

  // Method to validate the old phone number
  Future<void> _validateOldPhoneNumber() async {
    String oldPhoneNumber = _oldPhoneController.text;
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Query Firestore to check if the old phone number exists in the users collection
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.phoneNumber) // Using phone number as the document ID
            .get();

        if (userDoc.exists) {
          String? storedPhoneNumber = userDoc['phoneNumber'];
          if (storedPhoneNumber != null &&
              storedPhoneNumber == oldPhoneNumber) {
            // Proceed to the new phone number verification
            _sendOtp();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Old phone number does not match')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found with this old phone number')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error validating old phone number: ${e.toString()}')),
      );
    }
  }

  // Method to send OTP for new phone number verification
  Future<void> _sendOtp() async {
    String newPhoneNumber = _newPhoneController.text;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: newPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _updatePhoneNumber(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _isOtpSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  // Method to verify OTP and update the phone number
  Future<void> _verifyOtpAndUpdateNumber() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );
      await _updatePhoneNumber(credential);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP verification failed: ${e.toString()}")),
      );
    }
  }

  // Update phone number in Firebase Authentication and Firestore
  Future<void> _updatePhoneNumber(PhoneAuthCredential credential) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Update phone number in Firebase Authentication
      await user?.updatePhoneNumber(credential);

      // Update phone number in Firestore (replace old number with new number)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.phoneNumber)
          .update({
        'phoneNumber': _newPhoneController.text,
      });

      // Notify user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone number updated successfully")),
      );

      // Navigate back to previous screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Failed to update phone number: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _oldPhoneController,
              decoration: InputDecoration(labelText: 'Old Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _newPhoneController,
              decoration: InputDecoration(labelText: 'New Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPhoneController,
              decoration:
                  InputDecoration(labelText: 'Confirm New Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            if (_isOtpSent)
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'Enter OTP'),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isOtpSent) {
                  _verifyOtpAndUpdateNumber();
                } else {
                  // Validate old phone number and send OTP
                  if (_newPhoneController.text ==
                      _confirmPhoneController.text) {
                    _validateOldPhoneNumber();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('New phone numbers do not match')),
                    );
                  }
                }
              },
              child: Text(_isOtpSent ? 'Verify OTP' : 'Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
