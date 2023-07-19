import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dropdown_with_provider/dropdown_provider.dart';
import 'dropdown_with_provider/home_with_dropdown.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DropdownProvider())
        ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeWithDropDown(),
    );
  }
}