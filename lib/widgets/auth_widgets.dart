import 'package:flutter/material.dart';

const orange = Color(0xFFFF970D);
void openPage(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute<void>(builder: (_) => page));
void demoNotice(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

class OrangeLayout extends StatelessWidget {
  const OrangeLayout({
    super.key,
    required this.children,
    this.hero = true,
    this.footer,
    this.compactHero = false,
  });
  final List<Widget> children;
  final bool hero;
  final Widget? footer;
  final bool compactHero;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: LayoutBuilder(
                builder: (context, size) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: size.maxHeight),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (hero)
                          Stack(
                            children: [
                              Image.asset(
                                'assets/images/img_orange2.png',
                                width: double.infinity,
                                height: compactHero ? 220 : 370,
                                fit: BoxFit.fill,
                              ),
                              if (!compactHero)
                                const Positioned(
                                  top: 30,
                                  left: 24,
                                  child: BackCircle(),
                                ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(36, 22, 36, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: children,
                          ),
                        ),
                        if (footer != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 60, 30, 25),
                            child: footer,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class BackCircle extends StatelessWidget {
  const BackCircle({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 38,
        height: 38,
        child: IconButton.filled(
          style: IconButton.styleFrom(
            backgroundColor: const Color(0xFFFFF1BB),
            foregroundColor: Colors.white,
          ),
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.chevron_left),
          padding: EdgeInsets.zero,
        ),
      );
}

class OrangeButton extends StatelessWidget {
  const OrangeButton({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 58,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: orange,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      );
}

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.hint,
    required this.controller,
    this.password = false,
    this.keyboard = TextInputType.text,
    this.validator,
  });
  final String hint;
  final TextEditingController controller;
  final bool password;
  final TextInputType keyboard;
  final String? Function(String?)? validator;
  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.password && hidden,
          keyboardType: widget.keyboard,
          validator: widget.validator,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: orange),
            ),
            suffixIcon: widget.password
                ? IconButton(
                    onPressed: () => setState(() => hidden = !hidden),
                    icon: Icon(
                      hidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  )
                : null,
          ),
        ),
      );
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 22),
          const Row(
            children: [
              Expanded(child: Divider(color: orange)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('OR'),
              ),
              Expanded(child: Divider(color: orange)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final item in [
                ('img_g.png', 'Google'),
                ('img_f.png', 'Facebook'),
                ('img_a.png', 'Apple'),
              ])
                IconButton(
                  onPressed: () => demoNotice(
                    context,
                    '${item.$2} sign-in is a UI demonstration.',
                  ),
                  icon: Image.asset(
                    'assets/images/${item.$1}',
                    width: 30,
                    height: 30,
                  ),
                ),
            ],
          ),
        ],
      );
}

String? requiredValue(String? value) =>
    value == null || value.trim().isEmpty ? 'Please complete this field' : null;
String? validEmail(String? value) => value == null ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value.trim())
    ? 'Enter a valid email address'
    : null;

class AccountLink extends StatelessWidget {
  const AccountLink({
    super.key,
    required this.prompt,
    required this.action,
    required this.onTap,
  });
  final String prompt;
  final String action;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(prompt, style: const TextStyle(fontSize: 11)),
          TextButton(
            onPressed: onTap,
            child: Text(
              action,
              style: const TextStyle(color: orange, fontSize: 11),
            ),
          ),
        ],
      );
}
