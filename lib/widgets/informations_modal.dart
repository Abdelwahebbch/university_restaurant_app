import 'dart:async';
import 'package:flutter/material.dart';

class InformationsWidget extends StatefulWidget {
  final Duration initialWaitingTime;
  final int rank;

  const InformationsWidget({
    super.key,
    required this.initialWaitingTime,
    required this.rank,
  });

  @override
  State<InformationsWidget> createState() => _InformationsWidgetState();
}

class _InformationsWidgetState extends State<InformationsWidget> {
  late Duration remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.initialWaitingTime;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - Duration(seconds: 1);
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0891B2).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InfoRow(
              label: "Temps d'attente estimé",
              value: formatDuration(remainingTime),
              theme: theme,
            ),
            const SizedBox(height: 30),
            InfoRow(
              label: "Votre rang",
              value: widget.rank.toString(),
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF4B5563),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
