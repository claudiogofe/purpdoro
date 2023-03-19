import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final bool paused;
  final Map timers;
  final int sessionsBeforeLongBreak;
  final int currentSession;
  final int remaining;
  final VoidCallback reset;
  final VoidCallback toggleTimer;
  final VoidCallback skipSession;
  final String Function() getSessionName;

  const TimerPage({
    super.key,
    required this.paused,
    required this.timers,
    required this.sessionsBeforeLongBreak,
    required this.currentSession,
    required this.remaining,
    required this.reset,
    required this.toggleTimer,
    required this.skipSession,
    required this.getSessionName,
  });

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with AutomaticKeepAliveClientMixin<TimerPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.getSessionName(),
              style: TextStyle(
                color: Colors.deepPurple.shade200,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${(widget.remaining ~/ 60).toInt().toString().padLeft(2, "0")}:${(widget.remaining % 60).toInt().toString().padLeft(2, "0")}",
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
                  icon: widget.paused
                      ? Icon(Icons.play_circle_rounded)
                      : Icon(Icons.pause_circle_filled),
                  onPressed: widget.toggleTimer,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.deepPurple.shade400,
                    ),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                  ),
                  label: Text(widget.paused ? "Start" : "Pause"),
                ),
                const SizedBox(
                  width: 8,
                ),
                FilledButton.icon(
                  icon: const Icon(Icons.arrow_right_alt_rounded),
                  onPressed: widget.skipSession,
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
              onPressed: widget.reset,
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
