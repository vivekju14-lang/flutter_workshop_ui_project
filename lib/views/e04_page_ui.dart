import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import 'e03_page_ui.dart';
import 'e05_page_ui.dart';

class E04PageUI extends StatefulWidget {
  const E04PageUI({super.key});
  @override
  State<E04PageUI> createState() => _E04PageUIState();
}

class _E04PageUIState extends State<E04PageUI> {
  final email = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OrangeLayout(
        footer: AccountLink(
          prompt: "Don't have an Account?",
          action: 'Create Account',
          onTap: () => openPage(context, const E03PageUI()),
        ),
        children: [
          const Text(
            'Forgot your password?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text('Enter email address'),
          const SizedBox(height: 12),
          Form(
            key: form,
            child: AuthField(
              hint: '',
              controller: email,
              keyboard: TextInputType.emailAddress,
              validator: validEmail,
            ),
          ),
          OrangeButton(
            label: 'Send code',
            onPressed: () {
              if (form.currentState!.validate()) {
                openPage(context, E05PageUI(email: email.text.trim()));
              }
            },
          ),
        ],
      );
}
