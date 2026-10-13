import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workshop_ui_project/views/e01_page_ui.dart';
import 'package:flutter_workshop_ui_project/views/e02_page_ui.dart';
import 'package:flutter_workshop_ui_project/views/e03_page_ui.dart';
import 'package:flutter_workshop_ui_project/views/e04_page_ui.dart';
import 'package:flutter_workshop_ui_project/views/e05_page_ui.dart';
import 'package:flutter_workshop_ui_project/views/e06_page_ui.dart';

void main() {
  setUpAll(() async {
    final font = FontLoader('OrangeFont')
      ..addFont(rootBundle.load('assets/fonts/roboto-regular.ttf'))
      ..addFont(rootBundle.load('assets/fonts/roboto-bold.ttf'));
    await font.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets('six screens fit the reference viewport', (tester) async {
    tester.view.physicalSize = const Size(430, 932);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const pages = [
      E01PageUI(),
      E02PageUI(),
      E03PageUI(),
      E04PageUI(),
      E05PageUI(),
      E06PageUI()
    ];
    for (var i = 0; i < pages.length; i++) {
      await tester.pumpWidget(MaterialApp(
          theme: ThemeData(
              fontFamily: 'OrangeFont',
              scaffoldBackgroundColor: Colors.white,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: const Color(0xFFFF970D))),
          home: RepaintBoundary(
              key: const ValueKey('preview'), child: pages[i])));
      await tester.runAsync(() async {
        final context = tester.element(find.byKey(const ValueKey('preview')));
        for (final file in [
          'img_orange1.png',
          'img_orange2.png',
          'img_orange3.png',
          'img_g.png',
          'img_f.png',
          'img_a.png'
        ]) {
          await precacheImage(AssetImage('assets/images/$file'), context);
        }
      });
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await expectLater(find.byKey(const ValueKey('preview')),
          matchesGoldenFile('previews/e0${i + 1}.png'));
    }
    await tester.pumpWidget(const SizedBox());
  });
}
