import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  // test daha başlamadan setup çalıştırılır
  setUp() {
    if (kDebugMode) {
      print('hello');
    }
  }

  test("User Login Fail Test", () {
    const isUserLogin = true;
    expect(isUserLogin, isTrue);
  });

  group("User Login Full Test", () {
    //MARK:test1
    test("User Login Fail Test", () {
      const isUserLogin = true;
      expect(isUserLogin, isTrue);
    });
    //MARK:test2
    test("User Login Fail Test", () {
      const isUserLogin = true;
      expect(isUserLogin, isTrue);
    });
    //MARK:test3
    test("User Login Fail Test", () {
      const isUserLogin = true;
      expect(isUserLogin, isTrue);
    });
  });
}
