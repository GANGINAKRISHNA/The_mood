import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

/* Removed incorrect ChangeNotifierProvider class. */

// Mood Model - The "Brain" of our app
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy.jpeg';
  Color _backgroundColor = Colors.yellow;

  // Mood counters
  Map<String, int> _moodCounts = {
    'Happy': 0,
    'Sad': 0,
    'Excited': 0,
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = 'assets/happy.jpeg';
    _backgroundColor = Colors.yellow;
    _moodCounts['Happy'] = (_moodCounts['Happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.jpeg';
    _backgroundColor = Colors.blue;
    _moodCounts['Sad'] = (_moodCounts['Sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.jpg';
    _backgroundColor = Colors.orange;
    _moodCounts['Excited'] = (_moodCounts['Excited'] ?? 0) + 1;
    notifyListeners();
  }
}

// Main App Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// Home Page
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Scaffold(
          backgroundColor: moodModel.backgroundColor,
          appBar: AppBar(title: const Text('Mood Toggle Challenge')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('How are you feeling?', style: TextStyle(fontSize: 24)),
                SizedBox(height: 30),
                MoodDisplay(),
                SizedBox(height: 50),
                MoodButtons(),
                SizedBox(height: 40),
                MoodCounter(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget that displays the current mood
class MoodDisplay extends StatelessWidget {
  const MoodDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          height: 120,
          width: 120,
        );
      },
    );
  }
}

// Widget with buttons to change the mood
class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          child: const Text('Happy'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          child: const Text('Sad'),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          child: const Text('Excited'),
        ),
      ],
    );
  }
}

// Widget to display mood counters
class MoodCounter extends StatelessWidget {
  const MoodCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Text("Mood Counters", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("😊 Happy: ${moodModel.moodCounts['Happy']}"),
            Text("😢 Sad: ${moodModel.moodCounts['Sad']}"),
            Text("🎉 Excited: ${moodModel.moodCounts['Excited']}"),
          ],
        );
      },
    );
  }
}
