import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ChillStudyApp());
}

class ChillStudyApp extends StatelessWidget {
  const ChillStudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChillStudyApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ChillHomePage(),
    );
  }
}

class ChillHomePage extends StatefulWidget {
  const ChillHomePage({super.key});

  @override
  State<ChillHomePage> createState() => _ChillHomePageState();
}

class _ChillHomePageState extends State<ChillHomePage> {
  String plan = "";
  bool started = false;

  Future<void> generatePlan() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final hour = now.hour;
    final wakeTime = "${hour.toString().padLeft(2, '0')}:00";

    final planText = """
🌴 **Dein Chill & Study Plan**

🕗 Aufgestanden um: $wakeTime
☕ 1.–2. Stunde: Frühstück & Kaffee
📘 Danach: 3x 90 min Lernen mit Pausen
🏊 Pause zwischendurch: Schwimmen oder TFT
🌅 Abend: Relaxen, Sonnenuntergang & kurze Wiederholung

Bleib locker, du schaffst das! 😎
""";

    await prefs.setString('todayPlan', planText);
    setState(() {
      plan = planText;
      started = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('🏖️ ChillStudyApp'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: started
              ? SingleChildScrollView(
                  child: Text(plan, style: const TextStyle(fontSize: 18)),
                )
              : ElevatedButton.icon(
                  onPressed: generatePlan,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Tag starten'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                ),
        ),
      ),
    );
  }
}
