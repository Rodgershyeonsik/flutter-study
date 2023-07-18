// class 안에서 static 변수 사용할 때
// [클래스명.변수명]과 [변수명]이 같은 값을 참조하는 건지 간단하게 테스트 해봄.

void main() {
  print(User.name);
  User.name = "철수";
  print("User.name으로 접근해서 name 철수로 변경: ${User.name}");
  User.changeName('영수');
  print("User의 static 메서드 안에서 name으로 접근해서 영수로 변경: ${User.name}");
  User().printIsSameName();
}

class User {
  static String name = "광수";

  static void changeName(String newName) {
    name = newName;
  }

  void printIsSameName() {
    print(User.name == name);
  }
}