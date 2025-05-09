import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks {

  @override
  Color backgroundColor() => const Color(0xff211f30);

  late final CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  @override
  
  @override
  FutureOr<void> onLoad() async {
    //  load all images into cache
    await images.loadAllImages();

    final world = Level(
    player: player,
    levelName: 'Level-01');

    cam = CameraComponent.withFixedResolution(world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);

    addJoystick();
    
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updateJoystick();
    super.update(dt);
  }
  
  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 20, bottom: 32),
      priority: 10,
    );
    add(joystick);
  }
  
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;

    }
  }
}