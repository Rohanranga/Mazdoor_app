import 'package:flutter/material.dart';
import 'package:mazdoor_user/Pages/faninstallation.dart';

class ServiceSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Electrician'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
              'Select the services from below',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            serviceCategory('Fan', [
              'Fan Installation/ Uninstall',
              'Fan Replacement',
              'Fan Regulator Repair'
            ], context), // Pass the context to enable navigation

            Divider(thickness: 1, color: Colors.grey), // Add divider between categories

            serviceCategory('Light', [
              'Bulb/Tube light holder installation',
              'Decorative Lights Installation',
              'Light Installation'
            ], context),

            Divider(thickness: 1, color: Colors.grey), // Add divider between categories

            serviceCategory('Doorbell', [
              'Doorbell Bell Installation',
            ], context),

            Divider(thickness: 1, color: Colors.grey), // Add divider between categories

            serviceCategory('Switch and Sockets', [
              'Switch box installation',
              'AC Switch box installation',
              'Switch Board Installation',
              'Switch Board Replacement',
              'Switch/Socket replacement/repair',
            ], context),

            Divider(thickness: 1, color: Colors.grey), // Add divider between categories

            serviceCategory('Wiring', [
              'External Wiring',
            ], context),

            Divider(thickness: 1, color: Colors.grey), // Add divider between categories

            serviceCategory('MCB & Sub meter', [], context),
          ],
        ),
      ),
    );
  }

  Widget serviceCategory(String title, List<String> services, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: services.map((service) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.grey[300], // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                if (service == 'Fan Installation/ Uninstall') {
                  // Navigate to FanInstallationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FanInstallationPage(),
                    ),
                  );
                }
              },
              child: Text(service),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
