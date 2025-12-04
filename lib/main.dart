import 'package:flutter/material.dart';
import 'screen/message_screen.dart';
import 'screen/user_screen.dart';
import 'screen/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env.local");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/message': (context) => const MessageScreen(),
        '/user': (context) => const UserScreen(),
      },
    );
  }
}
