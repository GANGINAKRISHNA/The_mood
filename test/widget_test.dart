import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' show WidgetTester, expect, find, findsOneWidget, testWidgets;
import 'package:in_class_7/main.dart';
import 'package:provider/provider.dart';

// Adjust this import to match the "name:" in your pubspec.yaml

void main() {
  testWidgets('Mood app UI loads correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MoodModel(),
        child: const MaterialApp(home: HomePage()),
      ),
    );

    // Check header text
    expect(find.text('How are you feeling?'), findsOneWidget);

    // Check buttons are present
    expect(find.widgetWithText(ElevatedButton, 'Happy'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Sad'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Excited'), findsOneWidget);
  });

  testWidgets('Happy button increments Happy counter', (WidgetTester tester) async {
    // Build the app with provider
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => MoodModel(),
        child: const MaterialApp(home: HomePage()),
      ),
    );

    // Initial Happy counter should be 0
    expect(find.text('😊 Happy: 0'), findsOneWidget);

    // Tap Happy button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Happy'));
    await tester.pumpAndSettle();

    // Counter should now be 1
    expect(find.text('😊 Happy: 1'), findsOneWidget);
  });
}
