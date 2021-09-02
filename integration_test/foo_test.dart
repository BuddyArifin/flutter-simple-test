import 'package:flutter_test/flutter_test.dart';
import 'package:gallery/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  group('first test suites', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('first test case', (tester) async {
      app.main();
      print('XXXX');
      await tester.pumpAndSettle();
    });
  });
}
