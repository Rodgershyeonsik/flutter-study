import 'package:get/get.dart';
import 'model.dart';

class Controller extends GetxController{
  final person = Person().obs; // .obs로 obserable 로 만듦.

  void updateInfo(){
    // state의 현재 value 값을 가져와 person 클래스 내의 데이터 값 변경.
    person.update((val) {
      val?.age++;
      val?.name = '철수킴';
    });
  }
}