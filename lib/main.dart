library main;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/utils/magister/login.dart';
import 'src/utils/magister/profileInfo.dart';

part 'src/ui/Introduction.dart';
part 'src/utils/tabs.dart';
part 'src/utils/buildDrawer.dart';
part 'src/layout.dart';
part 'src/ui/tabs/Thuis.dart';
part 'src/ui/tabs/Agenda.dart';
part 'src/ui/tabs/Cijfers.dart';
part 'src/ui/tabs/Huiswerk.dart';
part 'src/ui/tabs/Afwezigheid.dart';
part 'src/ui/tabs/Berichten.dart';
part 'src/ui/tabs/Studiewijzer.dart';
part 'src/ui/tabs/Opdrachten.dart';
part 'src/ui/tabs/Leermiddelen.dart';
part 'src/ui/tabs/Bronnen.dart';
part 'src/ui/tabs/MijnGegevens.dart';
part 'src/ui/tabs/Instellingen.dart';

MagisterAuth magisterAuth = new MagisterAuth();
Box userdata;
void main() async {
  await Hive.initFlutter();
  await Hive.openBox("userdata");
  await Hive.openBox("magisterData");
  await Hive.openBox("magisterTokens");
  userdata = Hive.box("userdata");
  runApp(App());
  print("Userdata: " + userdata.toMap().toString());
  print("magisterTokens: " + Hive.box("magisterTokens").toMap().toString());
  print("magisterData: " + Hive.box("magisterData").toMap().toString());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magistex',
      theme: ThemeData(
        brightness: userdata.get("darkMode", defaultValue: false) ? Brightness.dark : Brightness.light,
        primaryColor: Color(userdata.get("primaryColor") ?? 4280391411),
        accentColor: Color(userdata.get("accentColor") ?? 4280391411),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "Introduction": (context) => Introduction(),
      },
      // home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}
