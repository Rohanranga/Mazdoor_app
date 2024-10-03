import 'package:flutter/material.dart';
import 'homepage.dart';

class Services extends StatelessWidget {
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
            height: availableHeight, // Full available height
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
                        // Action when pressed
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
                      imagePath: 'images/ca_wash.png',
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
                      width:150,
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
