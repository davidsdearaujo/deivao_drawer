library deivao_drawer;

import 'dart:math';

import 'package:deivao_drawer/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'drawer_animation_mixin.dart';
export 'drawer_controller.dart';

class DeivaoDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  final DeivaoDrawerController controller;

  DeivaoDrawer({
    Key key,
    @required this.drawer,
    @required this.child,
    DeivaoDrawerController controller,
  })  : assert(drawer != null),
        assert(child != null),
        controller = controller ?? DeivaoDrawerController(),
        super(key: key);

  @override
  _DeivaoDrawerState createState() => _DeivaoDrawerState();
}

class _DeivaoDrawerState extends State<DeivaoDrawer>
    with TickerProviderStateMixin, DrawerAnimationMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller.animation = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          enableDrawing = controller.value == 1 ||
              (details.globalPosition.dx <
                  MediaQuery.of(context).size.height * 0.1);
        },
        onHorizontalDragUpdate: (details) {
          if (enableDrawing)
            controller.value +=
                details.primaryDelta / MediaQuery.of(context).size.width * 1.5;
        },
        onHorizontalDragEnd: (details) {
          if (controller.value > 0.5)
            controller.forward();
          else
            controller.reverse();
        },
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              animation: controller,
              child: Material(child: widget.drawer),
              builder: (context, _child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0005)
                    ..rotateY(-pi * drawerRotationAnim.value)
                    ..translate(drawerTranslationAnim.value.dx),
                  // ..translate(drawerTranslationAnim.value.dx, drawerTranslationAnim.value.dy)
                  // ..scale(1.0, drawerScaleAnim.value),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: double.infinity,
                    child: _child,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: scaffoldTranslationAnim,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: widget.child,
              ),
              builder: (context, _child) {
                return Transform.translate(
                  offset: scaffoldTranslationAnim.value,
                  child: _child,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
