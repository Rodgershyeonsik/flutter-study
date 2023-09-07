import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:study/getx_test/personal_card.dart';

void main() {
  runApp(const GetXExApp());
}

class GetXExApp extends StatelessWidget {
  const GetXExApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: PersonalCard(),
    );
  }
}
