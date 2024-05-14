import 'package:flutter/material.dart';
import 'package:wisdomwords/screens/detail_page.dart';
import 'package:wisdomwords/screens/edit_page.dart';
import 'package:wisdomwords/screens/favourite_page.dart';
import 'package:wisdomwords/screens/homepage.dart';
import 'package:wisdomwords/screens/more_page.dart';
import 'package:wisdomwords/screens/splash.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(fontFamily: 'marc'),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => splashscreen(),
          'homepage': (context) => home_Page(),
          'detail_page': (context) => detail_page(),
          'favourite_page': (context) => favourite_Page(),
          'edit_page': (context) => EditPage(),
          'more_page': (context) => morePage(),
        }),
  );
}
