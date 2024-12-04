import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  Future<String>? cityFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Builder Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Potsleitzahl",
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  setState(
                    () {
                      cityFuture = getCityFromZip(controller.text);
                    },
                  );
                },
                child: const Text("Suche"),
              ),
              const SizedBox(height: 32),
              FutureBuilder<String>(
                future: cityFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Text("Ergebnis: ${snapshot.data}",
                        style: Theme.of(context).textTheme.labelLarge);
                  } else {
                    return const Text(
                      "Ergebnis: Noch keinee PLZ gesucht",
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    await Future.delayed(const Duration(seconds: 3));

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
