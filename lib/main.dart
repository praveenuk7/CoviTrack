import 'package:flutter/material.dart';

import 'DataSource.dart';
import 'Pages/SplashScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Circular', primaryColor: primaryBlack),
    home: SplashScreen(),
  ));
}
