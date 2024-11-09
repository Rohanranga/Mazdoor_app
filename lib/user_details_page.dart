import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends StatefulWidget {
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  DateTime? _selectedDate;
  String _gender = '';
  String _profileImageUrl = '';
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load data and image when the screen loads
  }

  // Fetch user data and image URL
  Future<void> _loadUserData() async {
    String? phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (phoneNumber != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNumber)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        _nameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _ageController.text = userData['age']?.toString() ?? '';
        _gender = userData['gender'] ?? '';
        if (userData['dob'] != null) {
          _selectedDate = (userData['dob'] as Timestamp).toDate();
        }
        if (userData['profileImageUrl'] != null) {
          _profileImageUrl = userData['profileImageUrl'];
        }
        setState(() {});
      }
    }
  }

  // Save or update user data and upload image if selected
  Future<void> _saveUserData() async {
    String? phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
    if (phoneNumber != null) {
      if (_profileImage != null) {
        await _uploadProfileImage(phoneNumber);
      }

      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'age': int.tryParse(_ageController.text),
          'dob':
              _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
          'gender': _gender,
          'profileImageUrl': _profileImageUrl, // Save the image URL
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User  data saved successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number not found')),
      );
    }
  }

  // Upload the selected image to Firebase Storage and get the URL
  Future<void> _uploadProfileImage(String phoneNumber) async {
    if (_profileImage == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$phoneNumber.jpg');

      // Upload the file
      UploadTask uploadTask = storageRef.putFile(_profileImage!);
      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        _profileImageUrl = await storageRef.getDownloadURL();
        setState(() {}); // Update UI with new image URL
      } else {
        throw Exception('Upload failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  // Select image using image picker
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' No image selected')),
      );
    }
  }

  // Pick date of birth
  Future<void> _pickDateOfBirth() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User  Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _selectImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : (_profileImageUrl.isNotEmpty
                          ? NetworkImage(_profileImageUrl)
                          : null),
                  child: _profileImage == null && _profileImageUrl.isEmpty
                      ? Icon(Icons.add_a_photo, size: 30)
                      : null,
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Date of Birth: '),
                Text(
                  _selectedDate != null
                      ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                      : 'Select Date',
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDateOfBirth,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Gender:'),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Text('Female'),
                Radio<String>(
                  value: 'Other',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Text('Other'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUserData,
              child: Text('Save Details'),
            ),
          ],
        ),
      ),
    );
  }
}
