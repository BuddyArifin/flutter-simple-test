import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('test suites', () {
    FlutterDriver driver;

    // Screen one
    final replyText = find.text('Reply');
    final shrineText = find.text('Shrine');
    final durationSwipe = const Duration(milliseconds: 500);

    // Screen two
    final usernameTxtField = find.byValueKey('username');
    final passwordTxtField = find.byValueKey('password');
    final nextButton = find.text('NEXT');

    // Screen three
    final hamburgerBar = find.byValueKey('hamburgerBar');
    final clothingMenu = find.text('CLOTHING');
    final accessoriesMenu = find.text('ACCESSORIES');
    final clothProduct = find.byValueKey('itemsProducts-5');
    final accessoriesProduct = find.byValueKey('itemsProducts-5');
    final scrollableProduct = find.byValueKey('scrollableProduct');
    final durationScroll = const Duration(seconds: 10);
    final totalItems = find.byValueKey('totalItems');
    final addToCart = find.byValueKey('add-to-cart');
    final clearCart = find.text('CLEAR CART');
    final itemOne = find.byValueKey('cart-item-0');
    final itemTwo = find.byValueKey('cart-item-1');

    setUpAll(() async {
      // Connect to a running Flutter application instance.
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) await driver.close();
    });

    test('Test Case: Find product and added to cart', () async {
      // Swipe into shrineText and tap
      await driver.scroll(replyText, -400, 0, durationSwipe);
      await driver.waitFor(shrineText);
      await driver.tap(shrineText);
      await driver.waitFor(nextButton);

      // Login
      await driver.tap(usernameTxtField);
      await driver.enterText('sampleusername');
      await driver.tap(passwordTxtField);
      await driver.enterText('sample');
      await driver.tap(nextButton);
      await driver.waitFor(hamburgerBar);

      // Find Products
      await driver.tap(hamburgerBar);
      await driver.tap(clothingMenu);
      await driver.scrollUntilVisible(scrollableProduct, clothProduct,
          dxScroll: -200.0, timeout: durationScroll);
      await driver.tap(clothProduct);
      await driver.tap(hamburgerBar);
      await driver.tap(accessoriesMenu);
      await driver.scrollUntilVisible(scrollableProduct, accessoriesProduct,
          dxScroll: -200.0, timeout: durationScroll);
      await driver.tap(accessoriesProduct);

      // checking / assertion
      await driver.tap(addToCart);
      expect(await driver.getText(totalItems), '2 ITEMS');

      // clear cart
      await driver.tap(clearCart);
    });
  });
}
