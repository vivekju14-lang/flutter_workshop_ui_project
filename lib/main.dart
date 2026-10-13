import 'package:flutter/material.dart';

import 'views/e01_page_ui.dart';

void main() => runApp(const OrangeApp());

class OrangeApp extends StatelessWidget {
  const OrangeApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Orange ส้ม',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OrangeFont',
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF970D)),
        ),
        home: const E01PageUI(),
      );
}
