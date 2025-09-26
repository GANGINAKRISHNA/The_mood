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

//added new

// Mood Model
class MoodModel with ChangeNotifier {
  String _currentMood = 'assets/happy.jpeg';
  Color _backgroundColor = Colors.yellow.shade200;

  final Map<String, int> _moodCounts = {
    'Happy': 0,
    'Sad': 0,
    'Excited': 0,
  };

  String get currentMood => _currentMood;
  Color get backgroundColor => _backgroundColor;
  Map<String, int> get moodCounts => _moodCounts;

  void setHappy() {
    _currentMood = 'assets/happy.jpeg';
    _backgroundColor = Colors.yellow.shade200;
    _moodCounts['Happy'] = (_moodCounts['Happy'] ?? 0) + 1;
    notifyListeners();
  }

  void setSad() {
    _currentMood = 'assets/sad.jpeg';
    _backgroundColor = Colors.blue.shade200;
    _moodCounts['Sad'] = (_moodCounts['Sad'] ?? 0) + 1;
    notifyListeners();
  }

  void setExcited() {
    _currentMood = 'assets/excited.jpg';
    _backgroundColor = Colors.orange.shade200;
    _moodCounts['Excited'] = (_moodCounts['Excited'] ?? 0) + 1;
    notifyListeners();
  }

  void resetMood() {
    _currentMood = 'assets/happy.jpeg'; // default
    _backgroundColor = Colors.yellow.shade200;
    _moodCounts.updateAll((key, value) => 0);
    notifyListeners();
  }
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
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
          appBar: AppBar(
            title: const Text('Mood Toggle App'),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'How are you feeling?',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Mood image inside a card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MoodDisplay(),
                  ),
                ),
                const SizedBox(height: 30),
                const MoodButtons(),
                const SizedBox(height: 40),
                const MoodCounter(),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Mood Display
class MoodDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMood,
          height: 140,
          width: 140,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

// Mood Buttons
class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 15,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[600],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setHappy();
          },
          icon: const Icon(Icons.sentiment_satisfied),
          label: const Text('Happy'),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[400],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setSad();
          },
          icon: const Icon(Icons.sentiment_dissatisfied),
          label: const Text('Sad'),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[400],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Provider.of<MoodModel>(context, listen: false).setExcited();
          },
          icon: const Icon(Icons.celebration),
          label: const Text('Excited'),
        ),
      ],
    );
  }
}

// Mood Counter with Reset All button
class MoodCounter extends StatelessWidget {
  const MoodCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Column(
          children: [
            Card(
              elevation: 6,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Mood Counters",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("😊 Happy: ${moodModel.moodCounts['Happy']}",
                        style: const TextStyle(fontSize: 16)),
                    Text("😢 Sad: ${moodModel.moodCounts['Sad']}",
                        style: const TextStyle(fontSize: 16)),
                    Text("🎉 Excited: ${moodModel.moodCounts['Excited']}",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Provider.of<MoodModel>(context, listen: false).resetMood();

                // Show small confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Moods and counters have been reset!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Reset All"), // ✅ minor change
            ),
          ],
        );
      },
    );
  }
}
