import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employee/pages/home_page.dart';
import 'package:employee/providers/emp_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmpProvider(),
      child: MaterialApp(
        title: 'employee list',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
