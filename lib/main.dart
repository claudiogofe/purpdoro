import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purpdoro/settings_page.dart';
import 'package:purpdoro/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  late PageController pageController;
  var _timers = {
    "work": 25,
    "break": 5,
    "longBreak": 15,
  };
  var _sessionsBeforeLongBreak = 8;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);
  }

  _setCurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  _setTimers(newTimers) {
    setState(() {
      _timers = newTimers;
    });
  }

  _setSessionsBeforeLongBreak(newValue) {
    setState(() {
      _sessionsBeforeLongBreak = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true
    return MaterialApp(
        title: "Purpdoro",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.deepPurple[400]),
        ),
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer_rounded),
                label: "Timer",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: "Settings",
              )
            ],
            onTap: (page) {
              pageController.animateToPage(page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            },
            backgroundColor: Colors.deepPurple,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.deepPurple[300],
          ),
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.deepPurple,
                systemNavigationBarColor: Colors.deepPurple),
            title: const SizedBox(
              width: double.infinity,
              child: Text(
                "Purpdoro",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: Colors.deepPurple,
            shadowColor: Colors.transparent,
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: _setCurrentPage,
            children: [
              TimerPage(
                timers: _timers,
                sessionsBeforeLongBreak: _sessionsBeforeLongBreak,
              ),
              SettingsPage(
                setTimers: _setTimers,
                timers: _timers,
              ),
            ],
          ),
        ));
  }
}
