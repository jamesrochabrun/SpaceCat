//
//  GameOverNode.h
//  MyGame
//
//  Created by James Rochabrun on 30-06-16.
//  Copyright © 2016 James Rochabrun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverNode : SKNode
+ (instancetype)gameOverAtPosition:(CGPoint)position;
- (void)performAnimation;

@end
