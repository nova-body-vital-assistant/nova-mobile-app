import 'package:flutter_test/flutter_test.dart';

import 'package:nova_mobile_app/main.dart';

void main() {
  testWidgets('App renders dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const NovaApp());
    expect(find.text('Caregiver Portal'), findsOneWidget);
    expect(find.text('Safe'), findsOneWidget);
  });
}
