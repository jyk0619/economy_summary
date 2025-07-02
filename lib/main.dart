import 'package:economy_summary/core/theme/app_theme.dart';
import 'package:economy_summary/viewmodels/currency_viemodel.dart';
import 'package:economy_summary/viewmodels/index_viewmodel.dart';
import 'package:economy_summary/viewmodels/stock_viewmodel.dart';
import 'package:flutter/material.dart';
import'package:economy_summary/views/home.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (_) => CurrencyViewModel()),
          ChangeNotifierProvider(create: (_) => IndexViewModel()),
          ChangeNotifierProvider(create: (_)=>ThemeProvider()),
      ChangeNotifierProvider(create: (_) => StockViewModel()),
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

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: MyHomePage(),
    );
  }
}
