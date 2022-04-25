// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test1', () {
    const a = 10;
    expect(a, 10);
  });

  test('計算実行テスト', () {
    const a = 9;
    const b = 4;
    final calc = Calc();
    final c = calc.add(a, b);
    expect(c, 13);
  });
}

class Calc {
  int add(int a, int b) => a + b;
}
