library deivao_drawer;

import 'dart:math';

import 'package:deivao_drawer/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'drawer_animation_mixin.dart';
export 'drawer_controller.dart';

class DeivaoDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  DeivaoDrawerController controller;

  DeivaoDrawer({
    Key key,
    @required this.drawer,
    @required this.child,
    this.controller,
  })  : assert(drawer != null),
        assert(child != null),
        super(key: key) {
    controller ??= DeivaoDrawerController();
  }

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
    return GestureDetector(
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
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(-pi * drawerRotationAnim.value)
                  ..translate(drawerTranslationAnim.value.dx)
                  ..scale(drawerScaleAnim.value),
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
    );
  }
}
