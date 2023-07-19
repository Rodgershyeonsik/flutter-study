import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dropdown_provider.dart';

class CustomDropdownButton extends StatelessWidget {
  const CustomDropdownButton({Key? key, required this.categoryList}) : super(key: key);
  final List<String> categoryList;

  @override
  Widget build(BuildContext context) {

    return DropdownButton<String>(
      value: context.watch<DropdownProvider>().category, // DropdownButton value에 provider의 value 할당
      hint: const Text('카테고리 선택'),
      elevation: 0,
      underline: const SizedBox.shrink(),
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold, fontSize: 20),
      onChanged: (String? value) {
        context.read<DropdownProvider>().categorySelected(value);
      },
      items: categoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}