import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  final Map timers;
  final int sessionsBeforeLongBreak;
  const TimerPage(
      {super.key, required this.timers, required this.sessionsBeforeLongBreak});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  var _paused = true;
  var _currentSession = 1;
  int _remaining = 25 * 60;
  Timer? _timer;

  _toggleTimer() {
    if (_paused || !_timer!.isActive) {
      setState(() {
        _paused = false;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (_remaining == 0) {
          _skipSession();
        } else {
          setState(() {
            _remaining--;
          });
        }
      });
    } else {
      _timer!.cancel();
      setState(() {
        _paused = true;
      });
    }
  }

  _skipSession() {
    setState(() {
      if (_currentSession + 1 == widget.sessionsBeforeLongBreak * 2) {
        _currentSession += 1;
        _remaining = widget.timers["longBreak"] * 60;
      } else if (_currentSession == widget.sessionsBeforeLongBreak * 2) {
        _currentSession = 1;
        _remaining = widget.timers["work"] * 60;
      } else if (_currentSession == widget.sessionsBeforeLongBreak * 2 ||
          _currentSession % 2 == 0) {
        _currentSession += 1;
        _remaining = widget.timers["work"] * 60;
      } else {
        _currentSession += 1;
        _remaining = widget.timers["break"] * 60;
      }
    });
  }

  _reset() {
    setState(() {
      _currentSession = 1;
      _remaining = widget.timers["work"] * 60;
      _paused = true;
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
    });
  }

  _getSessionName() {
    if (_currentSession % 2 == 0 &&
        _currentSession < widget.sessionsBeforeLongBreak * 2) {
      return "Break";
    } else if (_currentSession == widget.sessionsBeforeLongBreak * 2) {
      return "Long Break";
    } else {
      return "Work";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _getSessionName(),
              style: TextStyle(
                color: Colors.deepPurple.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${(_remaining ~/ 60).toInt().toString().padLeft(2, "0")}:${(_remaining % 60).toInt().toString().padLeft(2, "0")}",
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
                  icon: _paused
                      ? Icon(Icons.play_circle_rounded)
                      : Icon(Icons.pause_circle_filled),
                  onPressed: _toggleTimer,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.deepPurple.shade400,
                    ),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                  ),
                  label: Text(_paused ? "Start" : "Pause"),
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
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
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
        ));
  }
}
