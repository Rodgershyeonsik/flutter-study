import 'package:flutter/cupertino.dart';

class DropdownProvider extends ChangeNotifier {
  String? _category;
  String? get category => _category;

  void categorySelected(String? selectedCategory) {
    _category = selectedCategory;
    notifyListeners();
  }
}