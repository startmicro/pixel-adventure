bool checkCollision(player, block) {
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX = block.position.x;
  final blockY = block.position.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0 ? playerX - playerWidth : playerX;
  final fixedY = block.isPlatform ? playerY + playerHeight : playerY;

  return (fixedY < blockY + blockHeight &&
      playerY + playerHeight > blockY &&
      fixedX < blockX + blockWidth &&
      fixedX + playerWidth > blockX);
}
