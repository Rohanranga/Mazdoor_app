import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SwitchAndSocketsPage extends StatefulWidget {
  const SwitchAndSocketsPage({super.key});

  @override
  _SwitchAndSocketsPageState createState() => _SwitchAndSocketsPageState();
}

class _SwitchAndSocketsPageState extends State<SwitchAndSocketsPage> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? address;
  String? contact;
  double? price;
  bool isLoading = true; // Flag to show loading state

  @override
  void initState() {
    super.initState();
    fetchOrCreatePrice(); // Fetch the price from Firebase or create it if it doesn't exist
  }

  // Fetch price dynamically from Firebase or create the document if it doesn't exist
  void fetchOrCreatePrice() async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('prices').doc('switch_sockets');

      DocumentSnapshot snapshot = await docRef.get();

      if (snapshot.exists) {
        var fetchedPrice = snapshot['price']; // Fetch the price field
        // Convert the fetched price to double if it is an int
        setState(() {
          price = fetchedPrice is int ? fetchedPrice.toDouble() : fetchedPrice;
          isLoading = false; // Set loading to false after fetching
        });
        print("Fetched price from Firestore: $price");
      } else {
        // If the document doesn't exist, create it with a default price
        await docRef.set({
          'price': 300.0, // Default price value as a double
        });
        print('Document created with default price 300.0');

        setState(() {
          price = 300.0; // Set the default price value
          isLoading = false; // Set loading to false after creating
        });
      }
    } catch (e) {
      print("Error fetching or creating price: $e");
      setState(() {
        price = 0.0; // Default price in case of an error
        isLoading = false; // Stop loading
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching or creating price: $e')),
      );
    }
  }

  // Save booking information to Firestore
  void saveBooking() async {
    try {
      await FirebaseFirestore.instance.collection('bookings').add({
        'name': name,
        'address': address,
        'contact': contact,
        'price': price, // Include the service price
        'booking_time':
            FieldValue.serverTimestamp(), // Add a timestamp of booking
      });

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Booking Confirmed'),
          content: Text('Thank you, $name! Your booking is confirmed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error saving booking: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving booking: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fan Installation/Uninstall'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your details for the booking:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Name input
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
              ),

              // Address input
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
              ),

              // Contact input
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
                onSaved: (value) {
                  contact = value;
                },
              ),

              SizedBox(height: 20),

              // Display price or loader
              if (isLoading)
                Center(
                    child:
                        CircularProgressIndicator()) // Show loading spinner while fetching price
              else
                Text(
                  'Service Price: ₹${price?.toStringAsFixed(2)}', // Changed to show Rupee symbol
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

              Spacer(),

              // Book button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    saveBooking(); // Save the booking information to Firestore
                  }
                },
                child: Text('Book'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Background color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
