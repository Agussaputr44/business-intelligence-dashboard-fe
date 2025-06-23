import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashboard/providers/dashboard_provider.dart';
import 'package:dashboard/views/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: MaterialApp(
        title: 'Business Intelligence Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFF0D0D1A),
          // Ensure text scales appropriately for accessibility
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: MediaQuery.of(context).textScaler.scale(1.0),
              ),
        ),
        home: const DashboardPage(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}