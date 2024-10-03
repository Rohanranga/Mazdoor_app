import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mazdoor_user/HomePage/services.dart';

class Homepage extends StatelessWidget {
  final String location; // Pass the detected location as a parameter

  Homepage({required this.location});

  @override
  Widget build(BuildContext context) {
    // Get the total height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = AppBar().preferredSize.height;
    final bottomNavHeight = kBottomNavigationBarHeight;
    final availableHeight = screenHeight - appBarHeight - bottomNavHeight - 48; // Leave space for padding

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false, // Hides the back button if not needed
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.orange),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                location,
                style: TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2, // Allow up to 2 lines
                overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Scrollable if overflow occurs
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar at the top
              TextField(
                decoration: InputDecoration(
                  hintText: "Search your service",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.grey[300], // Light background color
                  filled: true,
                ),
              ),
              SizedBox(height: 16), // Space between search bar and rows

              // First row with images and button
              Container(
                height: availableHeight * 0.6, // 50% of available height
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // First image button with text
                        ImageButton(
                          imagePath: 'images/electrician.png',
                          label: 'Electrician',
                          onPressed: () {
                            // Add your onPressed action here
                          },
                        ),
                        // Second image button with text
                        ImageButton(
                          imagePath: 'images/Plumber.png',
                          label: 'Plumber',
                          onPressed: () {
                            // Add your onPressed action here
                          },
                        ),
                        // Third image button with text
                        ImageButton(
                          imagePath: 'images/Fridge2.png',
                          label: 'Fridge Repair',
                          onPressed: () {
                            // Add your onPressed action here
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Fourth image button with text (rectangle)
                        ImageButton(
                          imagePath: 'images/tv2.png',
                          label: 'TV Repair',
                          isRectangle: true, // Making this one a rectangle
                          onPressed: () {
                            // Add your onPressed action here
                          },
                        ),
                        // Fifth image button with text
                        ImageButton(
                          imagePath: 'images/car_wash.png',
                          label: 'Car Wash',
                          onPressed: () {
                            // Add your onPressed action here
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Button to "Explore all Services"
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        minimumSize: Size(double.infinity, 30), // Full width
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Services()),
                        );
                      },
                      child: Text(
                        'Explore all Services',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16), // Space between rows

              // Second row (smaller)
              Container(
                height: availableHeight * 0.3, // 30% of available height
                color: Colors.orange[200], // Placeholder color
                child: Center(child: Text('Second Row (Smaller)', style: TextStyle(fontSize: 16))),
              ),
              SizedBox(height: 10),
              // Third row (same size as second)
              Container(
                height: availableHeight * 0.4, // 40% of available height
                color: Colors.orange[300], // Placeholder color
                child: Center(child: Text('Third Row (Same as Second)', style: TextStyle(fontSize: 16))),
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange, // Selected icon color
        unselectedItemColor: Colors.grey,
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

// Custom image button widget
class ImageButton extends StatelessWidget {
  final String imagePath;
  final String label; // Text label to be displayed under the image
  final VoidCallback onPressed;
  final bool isRectangle;

  var width;

  ImageButton({
    required this.imagePath,
    required this.label,
    required this.onPressed,
    
    this.isRectangle = false, 
    this.width = 100.0,
    // Default is false (square)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isRectangle ? 200 : 100, // Rectangle or square size
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
