import 'package:flutter/material.dart';

mixin DrawerAnimationMixin<T extends StatefulWidget>
    on TickerProviderStateMixin<T> {
  AnimationController controller;

  Animation<double> drawerRotationAnim;
  Animation<double> drawerScaleAnim;
  Animation<Offset> drawerTranslationAnim;
  Animation<Offset> scaffoldTranslationAnim;

  bool enableDrawing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    drawerRotationAnim = Tween<double>(
      begin: 0.3,
      end: 0,
    ).animate(controller);

    drawerTranslationAnim = Tween<Offset>(
      begin: Offset(-100, 0),
      end: Offset(0, 0),
    ).animate(controller);

    drawerScaleAnim = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(controller);

    scaffoldTranslationAnim = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(MediaQuery.of(context).size.width * 0.8, 0),
    ).animate(controller);
  }

  void toggleDrawer() {
    if (controller.value == 0)
      controller.forward();
    else
      controller.reverse();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
