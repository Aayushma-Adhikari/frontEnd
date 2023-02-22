import 'package:flutter/material.dart';
import 'package:test/decryption.dart';
import 'package:test/secondscreen.dart';
import 'package:test/splashscreen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Steganography",
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 35, 116, 116),
        ),
        home: const splashscreen());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Steganography"),
          centerTitle: true,
          backgroundColor: Color(0xFF0C2A2A)),
      body: Column(
        children: [
          const SizedBox(height: 150),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const secondscreen()),
                );
              },
              icon: const Icon(
                Icons.lock_outlined,
                size: 50,
              ),
              style: ElevatedButton.styleFrom(
                  // ignore: prefer_const_constructors
                  backgroundColor: Color(0xFF0C2A2A),
                  padding: const EdgeInsets.all(30)),
              label: (const Text('ENCODE'))),
          const SizedBox(height: 50),
          const Padding(padding: EdgeInsets.only(left: 1000, right: 50)),
          ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const decryption()),
                );
              },
              icon: const Icon(Icons.lock_open_outlined, size: 50),
              style: ElevatedButton.styleFrom(
                  // ignore: prefer_const_constructors
                  backgroundColor: Color(0xFF0C2A2A),
                  padding: const EdgeInsets.all(30)),
              label: const Text('DECODE')),
        ],
      ),
    );
  }
}
