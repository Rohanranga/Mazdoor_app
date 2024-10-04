import 'package:flutter/material.dart';
import 'package:mazdoor_user/Pages/profilepage.dart';
import 'package:mazdoor_user/locationscreen.dart';
import 'homepage.dart'; // Assuming this is your HomePage
 // Assuming you have an Activity page

import 'package:mazdoor_user/Pages/electrician.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  int _selectedIndex = 1; // Set 'Services' tab as default

  // List of pages corresponding to the BottomNavigationBar items
  final List<Widget> _pages = [
    Homepage(location: 'Your Location'), // Home page
    ServicesPage(), // The modified Services page
    LocationScreen(), // Activity page
    UserProfilePage(), // Account/Profile page
  ];

  // This method is triggered when a BottomNavigationBar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Updates the selected tab index
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if the selected index is 1 (Services) to retain the old functionality
    if (_selectedIndex == 1) {
      // Old Services functionality
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Remove shadow
          automaticallyImplyLeading: true, // Show back button
          title: Text(
            "Services",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              // Use one container for all images
              height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - kBottomNavigationBarHeight - 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row with initial images
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageButton(
                        imagePath: 'images/electrician.png',
                        label: 'Electrician',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceSelectionScreen(),
                            ),
                          );
                        },
                      ),
                      ImageButton(
                        imagePath: 'images/Plumber.png',
                        label: 'Plumber',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                      ImageButton(
                        imagePath: 'images/Fridge2.png',
                        label: 'Fridge Repair',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageButton(
                        imagePath: 'images/tv2.png',
                        label: 'TV Repair',
                        isRectangle: true, // Rectangle image
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                      ImageButton(
                        imagePath: 'images/car_wash.png',
                        label: 'Car Wash',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Second row (3 additional images)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageButton(
                        imagePath: 'images/washingmachine2.png',
                        label: 'Washing Machine Repair',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                      ImageButton(
                        imagePath: 'images/car_wash.png',
                        label: 'Air Conditioner Services',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                      ImageButton(
                        imagePath: 'images/microwave.png',
                        label: 'Microwave Repair',
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Third row (one rectangular image)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageButton(
                        imagePath: 'images/1.png',
                        label: 'Abc',
                        isRectangle: true, // Rectangle image
                        width: 150,
                        onPressed: () {
                          // Action when pressed
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange, // Selected icon color
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      );
    } else {
      // Navigate to other pages based on the selected index
      return Scaffold(
        body: _pages[_selectedIndex], // Show the selected page
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange, // Selected icon color
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      );
    }
  }
}

// Placeholder for Services page used in the BottomNavigationBar
class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('This is the Services page.'));
  }
}

// Placeholder ImageButton widget
class ImageButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;
  final bool isRectangle;
  final double width;

  ImageButton({
    required this.imagePath,
    required this.label,
    required this.onPressed,
    this.isRectangle = false,
    this.width = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isRectangle ? 200 : width, // Rectangle or square size
        height: isRectangle ? 120 : 140, // Adjusted height
        decoration: BoxDecoration(
          color: Colors.grey[300], // Solid grey background for the image button
          borderRadius: BorderRadius.circular(10), // Border radius for the image
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: isRectangle ? 160 : 100,
              height: isRectangle ? 60 : 80, // Adjust the image size accordingly
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8), // Space between image and text
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
