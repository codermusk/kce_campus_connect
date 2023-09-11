import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kce_campus_connect/pages/department.dart';
import 'package:kce_campus_connect/pages/department_data.dart';
import 'package:kce_campus_connect/pages/hod_page.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Departments'),
      routes: {
        department.route: (ctx) => department(),
        DepartmentData.route: (ctx) => DepartmentData(),
        Hod.route: (ctx) => Hod(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(child: Text(widget.title)),
        ),
        body: Center(child: department()),

    );
  }
}
