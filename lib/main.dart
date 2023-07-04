import 'dart:collection';
import 'package:english_directory_flutter/packages/quote/quote.dart';
import 'package:english_directory_flutter/pages/control_page.dart';
import 'package:flutter/material.dart';
import 'package:english_directory_flutter/pages/leading_page.dart';
import 'package:english_directory_flutter/pages/home_page.dart';
import 'package:english_directory_flutter/packages/quote/quotes.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Langding_page(),
      debugShowCheckedModeBanner: false,
    );
  }
}
