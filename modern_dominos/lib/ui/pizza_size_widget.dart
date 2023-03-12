import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modern_dominos/data/pizza_controller.dart';

import '../utils/pizza_size_enum.dart';

class PizzaSizeWidget extends StatelessWidget {
  const PizzaSizeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const unSelectedSizeStyle = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );

    final selectedSizeStyle = TextStyle(
      fontSize: 18,
      color: Colors.red.shade700,
      fontWeight: FontWeight.w800,
    );
    final ctr = Get.put(PizzaController());

    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(height: 0.5, color: Colors.grey),
                  ),
                  const SizedBox(width: 42),
                  Expanded(
                    child: Container(height: 0.5, color: Colors.grey),
                  ),
                ],
              ),
              GetBuilder<PizzaController>(builder: (_) {
                return Row(
                  children: [
                    Container(height: 58, width: 0.5, color: Colors.grey),
                    ...List.generate(PizzaSizeEnum.values.length, (index) {
                      final size = PizzaSizeEnum.values[index];
                      final isSelected = ctr.selectedPizzaSize == size;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => ctr.onSizeChanged(size),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              size.name,
                              style: isSelected
                                  ? selectedSizeStyle
                                  : unSelectedSizeStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
                    Container(height: 58, width: 0.5, color: Colors.grey),
                  ],
                );
              }),
              Container(height: 0.5, color: Colors.grey),
              const SizedBox(height: 8),
            ],
          ),
          GetBuilder<PizzaController>(
            builder: (_) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                left: ctr.pizzaSizeIndicatorPosition,
                top: 64,
                child: Container(
                  height: 6,
                  width: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.red.shade700,
                  ),
                ),
              );
            },
          ),
          const Center(
            child: Text(
              'Size',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
