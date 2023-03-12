import 'package:get/get.dart';

import '../utils/constants.dart';
import '../utils/pizza_size_enum.dart';

class PizzaController extends GetxController {
  final animDuration = const Duration(milliseconds: 500);
  final textScaleAnimDuration = const Duration(milliseconds: 200);
  final extraOverlapPizzaSpace = 38.0;
  var selectedPizzaSize = PizzaSizeEnum.MEDIUM;
  var priceTextScale = 1.0;
  final rotationTurn = 0.0.obs;
  var currentVisiblePizzaIndex = 0;
  var isRotating = false;

  get pizzaSize => Get.width + (2 * extraOverlapPizzaSpace);

  double get pizzaSizeIndicatorPosition {
    final oneOptionSize = (Get.width - 64) / 3;
    switch (selectedPizzaSize) {
      case PizzaSizeEnum.SMALL:
        return (oneOptionSize / 2);
      case PizzaSizeEnum.MEDIUM:
        return oneOptionSize + (oneOptionSize / 2);
      case PizzaSizeEnum.LARGE:
        return (2 * oneOptionSize) + (oneOptionSize / 2);
    }
  }

  onSizeChanged(PizzaSizeEnum size) {
    selectedPizzaSize = size;

    _animatePriceText();
  }

  _animatePriceText() async {
    priceTextScale = 1.15;
    update();
    await Future.delayed(textScaleAnimDuration);
    priceTextScale = 1;
    update();
  }

  String pizzaPrice(int index) {
    switch (selectedPizzaSize) {
      case PizzaSizeEnum.SMALL:
        return pizzaSmallPrice[index];
      case PizzaSizeEnum.MEDIUM:
        return pizzaMediumPrice[index];
      case PizzaSizeEnum.LARGE:
        return pizzaLargePrice[index];
    }
  }

  onLeftSwipe() {
    if (isRotating) return;
    rotationTurn.value = rotationTurn.value - 1;
    if (currentVisiblePizzaIndex > 0) {
      currentVisiblePizzaIndex = currentVisiblePizzaIndex - 1;
    } else {
      currentVisiblePizzaIndex = pizzaAssets.length - 1;
    }
    isRotating = true;
    update();
    Future.delayed(animDuration).then((value) => isRotating = false);
  }

  onRightSwipe() {
    if (isRotating) return;
    rotationTurn.value = rotationTurn.value + 1;
    if (currentVisiblePizzaIndex < pizzaAssets.length - 1) {
      currentVisiblePizzaIndex = currentVisiblePizzaIndex + 1;
    } else {
      currentVisiblePizzaIndex = 0;
    }
    isRotating = true;
    update();
    Future.delayed(animDuration).then((value) => isRotating = false);
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 50)).then((value) => update());
  }
}
