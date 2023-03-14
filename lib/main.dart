import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _printStuff() {
    print("Test");
  }

  var paused = true;
  var sessionsBeforeLongBreak = 8;
  var currentSession = 1;
  var timers = {
    "work": 25,
    "break": 5,
    "longBreak": 15,
  };
  int remaining = 25 * 60;
  Timer? _timer;

  _toggleTimer() {
    if (paused || !_timer!.isActive) {
      setState(() {
        paused = false;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer _timer) {
        if (remaining == 0) {
          _skipSession();
        } else {
          setState(() {
            remaining--;
          });
        }
      });
    } else {
      _timer!.cancel();
      setState(() {
        paused = true;
      });
    }
  }

  _skipSession() {
    setState(() {
      if (currentSession + 1 == sessionsBeforeLongBreak) {
        currentSession += 1;
        remaining = timers["longBreak"]! * 60;
      } else if (currentSession == sessionsBeforeLongBreak) {
        currentSession = 1;
        remaining = timers["work"]! * 60;
      } else if (currentSession == sessionsBeforeLongBreak ||
          currentSession % 2 == 0) {
        currentSession += 1;
        remaining = timers["work"]! * 60;
      } else {
        currentSession += 1;
        remaining = timers["break"]! * 60;
      }
    });
  }

  _reset() {
    _timer!.cancel();
    setState(() {
      currentSession = 1;
      remaining = timers["work"]! * 60;
      paused = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true
    getSessionName() {
      if (currentSession % 2 == 0 && currentSession < sessionsBeforeLongBreak) {
        return "Break";
      } else if (currentSession == sessionsBeforeLongBreak) {
        return "Long Break";
      } else {
        return "Work";
      }
    }

    return MaterialApp(
        title: "Purpmodoro",
        home: Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.deepPurple,
                  systemNavigationBarColor: Colors.deepPurple),
              title: const SizedBox(
                width: double.infinity,
                child: Text(
                  "Purpmodoro",
                  textAlign: TextAlign.center,
                ),
              ),
              backgroundColor: Colors.deepPurple,
              shadowColor: Colors.transparent,
            ),
            body: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.deepPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getSessionName(),
                      style: TextStyle(
                        color: Colors.deepPurple.shade200,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${(remaining ~/ 60).toInt().toString().padLeft(2, "0")}:${(remaining % 60).toInt().toString().padLeft(2, "0")}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilledButton.icon(
                          icon: paused
                              ? Icon(Icons.play_circle_rounded)
                              : Icon(Icons.pause_circle_filled),
                          onPressed: _toggleTimer,
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.deepPurple.shade400,
                            ),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16)),
                          ),
                          label: Text(paused ? "Start" : "Pause"),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FilledButton.icon(
                          icon: const Icon(Icons.arrow_right_alt_rounded),
                          onPressed: _skipSession,
                          style: ButtonStyle(
                            side: MaterialStatePropertyAll(
                                BorderSide(color: Colors.deepPurple.shade400)),
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.deepPurple.shade500,
                            ),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16)),
                          ),
                          label: const Text("Skip"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    FilledButton.icon(
                      icon: const Icon(Icons.restart_alt_rounded),
                      onPressed: _reset,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.pink.shade400,
                        ),
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                      ),
                      label: const Text("Reset"),
                    ),
                  ],
                ))));
  }
}
