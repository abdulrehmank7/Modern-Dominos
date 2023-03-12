import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_dominos/data/pizza_controller.dart';
import 'package:modern_dominos/generated/assets.dart';
import 'package:modern_dominos/ui/pizza_size_widget.dart';
import 'package:modern_dominos/ui/pizza_widget.dart';
import 'package:modern_dominos/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ctr = Get.put(PizzaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.black],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 62,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(Assets.imagesDominosLogo, width: 150),
              ),
            ),
            const Positioned(
              top: 112,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'SELECT YOUR PIZZA',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Positioned(
              top: 72,
              left: 16,
              child: Icon(Icons.menu_rounded, color: Colors.white),
            ),
            const Positioned(
              top: 72,
              right: 16,
              child: Icon(Icons.person_3_rounded, color: Colors.white),
            ),
            GetBuilder<PizzaController>(builder: (_) {
              return Positioned(
                bottom: -ctr.pizzaSize / 1.0,
                left: -ctr.extraOverlapPizzaSpace,
                right: -ctr.extraOverlapPizzaSpace,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    int sensitivity = 10;
                    if (details.delta.dx > sensitivity) {
                      ctr.onRightSwipe();
                    } else if (details.delta.dx < -sensitivity) {
                      ctr.onLeftSwipe();
                    }
                  },
                  child: Stack(
                    children: List.generate(pizzaAssets.length, (index) {
                      return PizzaWidget(index);
                    }),
                  ),
                ),
              );
            }),
            const Positioned(
              top: 300,
              left: 0,
              right: 0,
              child: PizzaSizeWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
