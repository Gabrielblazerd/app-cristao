import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'home_page.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(ChristianApp()));
}

class ChristianApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplicativo Cristão',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
