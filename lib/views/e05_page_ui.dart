import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/auth_widgets.dart';
import 'e06_page_ui.dart';

class E05PageUI extends StatefulWidget {
  const E05PageUI({super.key, this.email = ''});
  final String email;
  @override
  State<E05PageUI> createState() => _E05PageUIState();
}

class _E05PageUIState extends State<E05PageUI> {
  final digits = List.generate(4, (_) => TextEditingController());
  final nodes = List.generate(4, (_) => FocusNode());
  int remaining = 30;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining == 0) {
        t.cancel();
      } else {
        setState(() => remaining--);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    for (final c in digits) {
      c.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OrangeLayout(
        hero: false,
        children: [
          const Row(
            children: [
              BackCircle(),
              Expanded(
                child: Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 38),
            ],
          ),
          const SizedBox(height: 58),
          Image.asset(
            'assets/images/img_orange3.png',
            height: 310,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 36),
          const Text(
            'Enter OTP',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Enter a 4 digit demo code to continue.',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i == 3 ? 0 : 8),
                    child: TextField(
                      controller: digits[i],
                      focusNode: nodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (v) {
                        if (v.isNotEmpty && i < 3) nodes[i + 1].requestFocus();
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE5E5E5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          remaining > 0
              ? Text(
                  'You should receive the OTP in $remaining Second',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: orange),
                )
              : TextButton(
                  onPressed: () {
                    setState(() => remaining = 30);
                    startTimer();
                    demoNotice(
                        context, 'Demo timer restarted; no email was sent.');
                  },
                  child: const Text('Resend code'),
                ),
          const SizedBox(height: 14),
          OrangeButton(
            label: 'Verify',
            onPressed: () {
              if (digits.any((d) => d.text.isEmpty)) {
                demoNotice(context, 'Enter all four digits');
              } else {
                openPage(context, const E06PageUI());
              }
            },
          ),
        ],
      );
}
