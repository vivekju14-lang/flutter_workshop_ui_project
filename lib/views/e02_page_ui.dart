import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';
import 'e03_page_ui.dart';
import 'e04_page_ui.dart';

class E02PageUI extends StatefulWidget {
  const E02PageUI({super.key});
  @override
  State<E02PageUI> createState() => _E02PageUIState();
}

class _E02PageUIState extends State<E02PageUI> {
  final email = TextEditingController(), password = TextEditingController();
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OrangeLayout(
        children: [
          const Text(
            'Welcome back',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text('Login to your account', textAlign: TextAlign.center),
          const SizedBox(height: 22),
          Form(
            key: form,
            child: Column(
              children: [
                AuthField(
                  hint: 'Enter email or phone',
                  controller: email,
                  validator: requiredValue,
                ),
                AuthField(
                  hint: 'Password',
                  controller: password,
                  password: true,
                  validator: requiredValue,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => openPage(context, const E04PageUI()),
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(fontSize: 12, color: orange),
              ),
            ),
          ),
          OrangeButton(
            label: 'Log In',
            onPressed: () {
              if (form.currentState!.validate()) {
                demoNotice(
                  context,
                  'Login UI completed. No authentication server is connected.',
                );
              }
            },
          ),
          const SocialButtons(),
          AccountLink(
            prompt: "Don't have an Account?",
            action: 'Create Account',
            onTap: () => openPage(context, const E03PageUI()),
          ),
        ],
      );
}
