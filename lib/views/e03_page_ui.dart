import 'package:flutter/material.dart';

import '../widgets/auth_widgets.dart';

class E03PageUI extends StatefulWidget {
  const E03PageUI({super.key});
  @override
  State<E03PageUI> createState() => _E03PageUIState();
}

class _E03PageUIState extends State<E03PageUI> {
  final fields = List.generate(4, (_) => TextEditingController());
  final form = GlobalKey<FormState>();
  @override
  void dispose() {
    for (final field in fields) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OrangeLayout(
        compactHero: true,
        children: [
          const Text(
            'Register',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Text('Create your new account', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Form(
            key: form,
            child: Column(
              children: [
                AuthField(
                  hint: 'Name',
                  controller: fields[0],
                  validator: requiredValue,
                ),
                AuthField(
                  hint: 'E-mail',
                  controller: fields[1],
                  keyboard: TextInputType.emailAddress,
                  validator: validEmail,
                ),
                AuthField(
                  hint: 'Phone',
                  controller: fields[2],
                  keyboard: TextInputType.phone,
                  validator: requiredValue,
                ),
                AuthField(
                  hint: 'Password',
                  controller: fields[3],
                  password: true,
                  validator: (v) => v == null || v.length < 8
                      ? 'Use at least 8 characters'
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'By signing up you agree to our Terms & Conditions\nand Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          ),
          const SizedBox(height: 24),
          OrangeButton(
            label: 'Sign Up',
            onPressed: () {
              if (form.currentState!.validate()) {
                demoNotice(
                  context,
                  'Registration form complete. This is a UI workshop.',
                );
                Navigator.pop(context);
              }
            },
          ),
          const SocialButtons(),
          AccountLink(
            prompt: 'Already have an Account?',
            action: 'Log In',
            onTap: () => Navigator.pop(context),
          ),
        ],
      );
}
