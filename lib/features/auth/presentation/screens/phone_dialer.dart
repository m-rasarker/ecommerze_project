import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneDialer extends StatefulWidget {
  const PhoneDialer({super.key});

  @override
  State<PhoneDialer> createState() => _PhoneDialerState();
}

class _PhoneDialerState extends State<PhoneDialer> {

  TextEditingController phone = TextEditingController(text: "01731920541");
  Future<void> _launchDialer(String phoneNumber) async {
    final Uri dialUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      throw 'Could not launch dialer for $phoneNumber';
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 200,),
            TextFormField(
              controller: phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: CupertinoColors.inactiveGray))),
            ),
          SizedBox( height: 20,),
         FilledButton(
          onPressed: () => _launchDialer(phone.text),
          child: Text('Dial' +  phone.text))

          ]
        ),
      ),
    );
  }
}
