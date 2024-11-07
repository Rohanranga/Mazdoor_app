import 'package:flutter/material.dart';
import 'package:mazdoor_user/services/Doorbell_installation/door_bell_installation.dart';
import 'package:mazdoor_user/services/fan_services/fan_regulator_repair.dart';
import 'package:mazdoor_user/services/fan_services/fan_replacement.dart';
import 'package:mazdoor_user/services/fan_services/faninstallation.dart';
import 'package:mazdoor_user/services/light_services/docorative_lights_installation.dart';
import 'package:mazdoor_user/services/light_services/holder_installation.dart';
import 'package:mazdoor_user/services/light_services/lights_installtion.dart';
import 'package:mazdoor_user/services/switch_and_sockets_service/ac_switch_installation.dart';
import 'package:mazdoor_user/services/switch_and_sockets_service/switch_board_replacement.dart';
import 'package:mazdoor_user/services/switch_and_sockets_service/switch_socket_repair.dart';
import 'package:mazdoor_user/services/switch_and_sockets_service/switch_sockets.dart';
import 'package:mazdoor_user/services/wiring_service/wiring.dart';
// import 'fan_services/faninstallation.dart';
// import 'fan_services/fan_replacement_page.dart';
// import 'fan_services/fan_regulator_repair_page.dart';
// import 'light_services/bulb_holder_installation_page.dart';
// import 'light_services/decorative_lights_installation_page.dart';
// import 'light_services/light_installation_page.dart';
// import 'doorbell_services/doorbell_installation_page.dart';
// import 'switch_services/switch_and_sockets_page.dart';
// import 'wiring_services/wiring_page.dart';
// import 'mcb_services/mcb_sub_meter_page.dart';

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
            serviceCategory(
                'Fan',
                [
                  'Fan Installation/ Uninstall',
                  'Fan Replacement',
                  'Fan Regulator Repair'
                ],
                context), // Pass the context to enable navigation

            Divider(
                thickness: 1,
                color: Colors.grey), // Add divider between categories

            serviceCategory(
                'Light',
                [
                  'Bulb/Tube light holder installation',
                  'Decorative Lights Installation',
                  'Light Installation'
                ],
                context),

            Divider(
                thickness: 1,
                color: Colors.grey), // Add divider between categories

            serviceCategory(
                'Doorbell',
                [
                  'Doorbell Bell Installation',
                ],
                context),

            Divider(
                thickness: 1,
                color: Colors.grey), // Add divider between categories

            serviceCategory(
                'Switch and Sockets',
                [
                  'Switch box installation',
                  'AC Switch box installation',
                  'Switch Board Installation',
                  'Switch Board Replacement',
                  'Switch/Socket replacement/repair',
                ],
                context),

            Divider(
                thickness: 1,
                color: Colors.grey), // Add divider between categories

            serviceCategory(
                'Wiring',
                [
                  'External Wiring',
                ],
                context),

            Divider(
                thickness: 1,
                color: Colors.grey), // Add divider between categories

            serviceCategory('MCB & Sub meter', [], context),
          ],
        ),
      ),
    );
  }

  Widget serviceCategory(
      String title, List<String> services, BuildContext context) {
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
                } else if (service == 'Fan Replacement') {
                  // Navigate to FanReplacementPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FanReplacementPage(),
                    ),
                  );
                } else if (service == 'Fan Regulator Repair') {
                  // Navigate to FanRegulatorRepairPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FanRegulatorPage(),
                    ),
                  );
                } else if (service == 'Bulb/Tube light holder installation') {
                  // Navigate to BulbHolderInstallationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BulbHolderInstallationPage(),
                    ),
                  );
                } else if (service == 'Decorative Lights Installation') {
                  // Navigate to DecorativeLightsInstallationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DecorativeLightsInstallationPage(),
                    ),
                  );
                } else if (service == 'Light Installation') {
                  // Navigate to LightInstallationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LightInstallationPage(),
                    ),
                  );
                } else if (service == 'Doorbell Bell Installation') {
                  // Navigate to DoorbellInstallationPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoorbellInstallationPage(),
                    ),
                  );
                } else if (service == 'Switch box installation') {
                  // Navigate to SwitchAndSocketsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchAndSocketsPage(),
                    ),
                  );
                } else if (service == 'AC Switch box installation') {
                  // Navigate to SwitchAndSocketsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcSwitchAndSocketsPage(),
                    ),
                  );
                } else if (service == 'Switch Board Installation') {
                  // Navigate to SwitchAndSocketsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchBoardReplacement(),
                    ),
                  );
                } else if (service == 'Switch Board Replacement') {
                  // Navigate to SwitchAndSocketsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchBoardReplacement(),
                    ),
                  );
                } else if (service == 'Switch/Socket replacement/repair') {
                  // Navigate to SwitchAndSocketsPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SwitchSocketRepair(),
                    ),
                  );
                } else if (service == 'External Wiring') {
                  // Navigate to WiringPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WiringPage(),
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
