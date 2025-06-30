import 'package:economy_summary/viewmodels/currency_viemodel.dart';
import 'package:flutter/material.dart';
import'package:economy_summary/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_) => CurrencyViewModel()),
    ],
      child:const MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      home: MyHomePage(),
    );
  }
}
