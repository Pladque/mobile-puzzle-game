import 'package:flutter/material.dart';
import 'package:logicandmathpuzzles/widgets/nav_button.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);
  final String _rateMeUrl = 'https://www.facebook.com/';

  void lunchInBrowser() {
    _launchInBrowser(_rateMeUrl);
  }

  Future<void> _launchInBrowser(String url) async {

      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'thanks for using my app!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 42,
          ),
          textAlign: TextAlign.center,
        ),
        NavButton(
          const Color.fromARGB(0, 255, 255, 255),
          lunchInBrowser,
          text: 'Rate me!',
          widthDivider: 1.2,
          onlyText: true,
        ),
      ],
    );
  }
}
