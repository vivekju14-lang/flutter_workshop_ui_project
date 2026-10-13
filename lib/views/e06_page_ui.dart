import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import 'e02_page_ui.dart';

class E06PageUI extends StatefulWidget {
  const E06PageUI({super.key});
  @override
  State<E06PageUI> createState() => _E06PageUIState();
}

class _E06PageUIState extends State<E06PageUI> {
  final password = TextEditingController(), confirm = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OrangeLayout(
        children: [
          const Text(
            'Create New Password',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text('Enter new password'),
          const SizedBox(height: 20),
          Form(
            key: form,
            child: Column(
              children: [
                AuthField(
                  hint: 'Enter New password',
                  controller: password,
                  password: true,
                  validator: (v) => v == null || v.length < 8
                      ? 'Use at least 8 characters'
                      : null,
                ),
                AuthField(
                  hint: 'Confirm password',
                  controller: confirm,
                  password: true,
                  validator: (v) => v != password.text
                      ? 'Passwords do not match'
                      : requiredValue(v),
                ),
              ],
            ),
          ),
          OrangeButton(
            label: 'Submit',
            onPressed: () {
              if (form.currentState!.validate()) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(builder: (_) => const E02PageUI()),
                  (r) => r.isFirst,
                );
                demoNotice(
                  context,
                  'Password form complete. No account password was changed.',
                );
              }
            },
          ),
        ],
      );
}
