import 'common.dart';

void main() {
  patrol(
    'interacts with the StackOverflow website in a webview',
    ($) async {
      await createApp($);

      await $('Open webview (StackOverflow)').scrollTo().tap();

      try {
        await $.native.tap(
          androidSelector: AndroidSelector(text: 'Accept all cookies'),
          iosSelector: IOSSelector(label: 'Accept all cookies'),
        );
      } on PatrolActionException catch (_) {
        // ignore
      }
      await $.native.tap(
        androidSelector: AndroidSelector(text: 'Log in'),
        iosSelector: IOSSelector(label: 'Log in'),
      );

      await $.pump(Duration(seconds: 2));

      // bug: using `Email` and `Password` selectors doesn't work (#1554)
      await $.native.enterTextByIndex('test@leancode.pl', index: 0);
      await $.native.enterTextByIndex('ny4ncat', index: 1);
      await $.native.tap(
        androidSelector: AndroidSelector(text: 'Log in'),
        iosSelector: IOSSelector(label: 'Log in'),
      );
    },
  );
}
