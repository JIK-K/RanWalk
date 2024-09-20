import 'package:flutter/material.dart';
import 'package:ranwalk/view/home_view.dart';
import 'package:ranwalk/view/map_view.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RanWalk',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.red)
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black
          )
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      routes: {
        "/" : (context) => HomeView(),
        "/map" : (context) => MapView(),
      },
      initialRoute: '/',
    );
  }
}


