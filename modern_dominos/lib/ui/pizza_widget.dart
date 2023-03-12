import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_dominos/data/pizza_controller.dart';
import 'package:modern_dominos/generated/assets.dart';
import 'package:modern_dominos/ui/arrow_painter.dart';

import '../utils/constants.dart';

class PizzaWidget extends StatelessWidget {
  final int index;

  const PizzaWidget(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctr = Get.put(PizzaController());

    return AnimatedOpacity(
      opacity: ctr.currentVisiblePizzaIndex == index ? 1 : 0,
      duration: ctr.animDuration,
      child: AnimatedRotation(
        duration: ctr.animDuration,
        turns: ctr.rotationTurn.value,
        child: Stack(
          children: [
            Positioned(
              top: 240,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(Assets.imagesStars),
                ),
              ),
            ),
            Positioned(
              left: 62,
              right: 62,
              top: 350,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    angle: math.pi - math.pi / 7,
                    child: CustomPaint(
                      painter: ArrowPainter(
                        strokeColor: Colors.grey,
                        strokeWidth: 1,
                        arrowLength: 100,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: const SizedBox(width: 100),
                    ),
                  ),
                  Transform.rotate(
                    angle: math.pi / 7,
                    child: CustomPaint(
                      painter: ArrowPainter(
                        strokeColor: Colors.grey,
                        strokeWidth: 1,
                        arrowLength: 100,
                        paintingStyle: PaintingStyle.fill,
                      ),
                      child: const SizedBox(width: 100),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                  width: Get.width - 64,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        pizzaName[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        pizzaDesc[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 200),
                SizedBox(
                  height: 38,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4, right: 2),
                        child: Text(
                          '₹',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      AnimatedScale(
                        scale: ctr.priceTextScale,
                        duration: ctr.textScaleAnimDuration,
                        child: Text(
                          ctr.pizzaPrice(index),
                          style: GoogleFonts.montserrat(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Image.asset(pizzaAssets[index], height: ctr.pizzaSize),
                const SizedBox(height: 348),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
