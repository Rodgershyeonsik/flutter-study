import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study/dropdown_with_provider/custom_dropdown.dart';

import 'dropdown_provider.dart';

class HomeWithDropDown extends StatelessWidget {
  const HomeWithDropDown({Key? key}) : super(key: key);
  static const List<String> categories = ['하나', '둘', '셋', '넷'];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('drop down button test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.lightBlue,
              padding: const EdgeInsets.all(10),
              child: const CustomDropdownButton(
                categoryList: categories,
              ),
            ),
            const SizedBox(height: 30,),
            Text('categoryValue: ${ context.watch<DropdownProvider>().category?? '아직 선택 안함'}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),)
          ],
        ),
      ),
    );
  }
}
