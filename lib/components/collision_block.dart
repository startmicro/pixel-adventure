import 'package:flame/components.dart';

class CollisionBlock extends PositionComponent {
  bool isPlatform;
  CollisionBlock({super.position, super.size, this.isPlatform = false});
  @override
  set debugMode(bool mydebugMode) {
    mydebugMode = true;
    super.debugMode = mydebugMode;
  }
}