import 'dart:async';

final censored = '¯\\_(ツ)_/¯';

Future<void> callPrint() async {
  await Future.delayed(
    Duration(milliseconds: 300),
    () {
      print('Hello Zone: ${Zone.current}');
    },
  );
  await Future.error(censored);
}

void main() async {
  await runZoned(
    () async {
      await callPrint();
    },
    zoneSpecification: ZoneSpecification(
      handleUncaughtError: (
        Zone self,
        ZoneDelegate parent,
        Zone zone,
        Object error,
        StackTrace stackTrace,
      ) {
        try {
          print('error: $error, stackTrace: $stackTrace');
        } catch (e, s) {
          if (identical(e, error)) {
            parent.handleUncaughtError(zone, error, stackTrace);
          } else {
            parent.handleUncaughtError(zone, e, s);
          }
        }
      },
    ),
  );
  print('Завершение программы');
}
