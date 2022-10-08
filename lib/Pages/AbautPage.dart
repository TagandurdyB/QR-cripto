import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_demo/Pages/Scaffold_all.dart';

import '../Public.dart';

class AbautPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldAll(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AbautText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontSize: screenWidth*0.039),
            ),
          ),
        ],
      ),
    );
  }
}
