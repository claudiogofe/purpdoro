import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsPage extends StatefulWidget {
  final Map timers;
  final void Function(Map) setTimers;
  final int sessionsBeforeLongBreak;
  final void Function(int) setSessionsBeforeLongBreak;

  const SettingsPage(
      {super.key,
      required this.timers,
      required this.setTimers,
      required this.sessionsBeforeLongBreak,
      required this.setSessionsBeforeLongBreak});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.deepPurple[500],
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Working",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Container(
              width: 96,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: NumberPicker(
                minValue: 1,
                maxValue: 60,
                value: widget.timers["work"],
                onChanged: (newValue) {
                  var newTimers = widget.timers;
                  newTimers["work"] = newValue;
                  widget.setTimers(newTimers);
                },
                textStyle:
                    TextStyle(color: Colors.deepPurple[300], fontSize: 16),
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Break",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Container(
              width: 96,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: NumberPicker(
                minValue: 1,
                maxValue: 60,
                value: widget.timers["break"],
                onChanged: (newValue) {
                  var newTimers = widget.timers;
                  newTimers["break"] = newValue;
                  widget.setTimers(newTimers);
                },
                textStyle:
                    TextStyle(color: Colors.deepPurple[300], fontSize: 16),
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Long Break",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Container(
              width: 96,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: NumberPicker(
                minValue: 1,
                maxValue: 60,
                value: widget.timers["longBreak"],
                onChanged: (newValue) {
                  var newTimers = widget.timers;
                  newTimers["longBreak"] = newValue;
                  widget.setTimers(newTimers);
                },
                textStyle:
                    TextStyle(color: Colors.deepPurple[300], fontSize: 16),
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Sessions Before Long Break",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Container(
              width: 96,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              child: NumberPicker(
                minValue: 1,
                maxValue: 60,
                value: widget.sessionsBeforeLongBreak,
                onChanged: (newValue) {
                  widget.setSessionsBeforeLongBreak(newValue);
                },
                textStyle:
                    TextStyle(color: Colors.deepPurple[300], fontSize: 16),
                selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
