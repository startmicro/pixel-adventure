import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/components/collision_block.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState {
  idle,running
}


class Player extends SpriteAnimationGroupComponent with HasGameReference<PixelAdventure>, KeyboardHandler{
  String character;
  Player({super.position, this.character = 'Ninja Frog'});

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  List<CollisionBlock> collisionBlocks = [];

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);
    
    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;
    
    return super.onKeyEvent(event, keysPressed);
  }
  
  void _loadAllAnimations() {
    
    //  create animation
    idleAnimation = _spriteAnimation('Idle', 11);
    runningAnimation = _spriteAnimation('Run', 12);

    //  list of all animation
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    //  set curret animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$character/$state (32x32).png'), 
    SpriteAnimationData.sequenced(
      amount: amount, 
      stepTime: stepTime, 
      textureSize: Vector2.all(32),
      ),
    );
  }
  
  void _updatePlayerMovement(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }
  
  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if(velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    }else if(velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    if(velocity.x != 0) playerState = PlayerState.running;

    current = playerState;
  }
  
  void _checkHorizontalCollisions() {
    for(final block in collisionBlocks) {
      
    }
  }
}