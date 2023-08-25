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

class DemoHome extends StatelessWidget {
  const DemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildRouteButton(context, "드롭다운 테스트", HomeWithDropDown()),
        ],
      )
    );
  }

  Widget _buildRouteButton(BuildContext context, String title, Widget widget) {
    return TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
        },
        child: Text(title))
    ;
  }
}
