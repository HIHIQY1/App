library main;

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:developer';
import 'dart:convert';

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:after_layout/after_layout.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flushbar/flushbar.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/utils/magister/login.dart';
import 'src/utils/hiveObjects.dart';
part 'src/ui/Introduction.dart';
part 'src/utils/tabs.dart';
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
part 'src/ui/tabs/Info.dart';

extension StringExtension on String {
  String get capitalize => "${this[0].toUpperCase()}${this.substring(1)}";
}

MagisterAuth magisterAuth = new MagisterAuth();
Account account;
_AppState appState;
Box userdata, accounts;
Brightness theme;

void showSnackbar(BuildContext context, String text) {
  Scaffold.of(context).removeCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(MaterialColorAdapter());
  Hive.registerAdapter(IconAdapter());
  userdata = await Hive.openBox("userdata");
  accounts = await Hive.openBox<Account>("accounts");
  if (accounts.isEmpty) {
    userdata.clear();
    userdata.putAll({
      "theme": "systeem",
      "primaryColor": Colors.blue,
      "accentColor": Colors.orange,
      "userIcon": Icons.person,
      "accountIndex": 0,
      "pixelsPerHour": 85,
    });
    print("Wrote dummy data");
    accounts.put(0, Account());
  }
  log("Userdata: " + userdata.toMap().toString());
  log("accounts: " + accounts.toMap().toString());
  // Hive.deleteFromDisk();
  // print("Deleted data");
  // return;
  int accountIndex = userdata.get("accountIndex");
  account = accounts.get(accountIndex) ?? accounts.get(0);
  log(account.toJson().toString());
  appState = _AppState();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => appState;
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    switch (userdata.get("theme")) {
      case "donker":
        theme = Brightness.dark;
        break;
      case "licht":
        theme = Brightness.light;
        break;
      default:
        theme = SchedulerBinding.instance.window.platformBrightness;
    }
    return MaterialApp(
      title: 'Magistex',
      theme: ThemeData(
        brightness: theme,
        primaryColor: userdata.get("primaryColor"),
        accentColor: userdata.get("accentColor"),
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// HomeState homeState = HomeState();

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}
